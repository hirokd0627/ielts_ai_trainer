import os
import base64
import json
from typing import override

from pydantic import BaseModel
from flask import Flask
from google import genai
from google.genai import types

from ai_api_proxy import AiApiProxy
from prompt_provider import PromptProvider
from settings import settings


class GeminiApi(AiApiProxy):
    """An implementation class to provide Gemini agent features.
    For details about methods, see `AiApiProxy`."""

    def __init__(self, app: Flask):
        self._client = genai.Client(api_key=settings.gemini_api_key)
        self._logger = app.logger
        self._promptProvider = PromptProvider(app)
        self._statusCheckModel = "gemini-2.5-flash-lite"
        if settings.env == "production":
            # production
            # self._textGenModel = "gemini-2.5-flash"
            self._textGenModel = "gemini-3-pro-preview"
            self._imgGenModel = "gemini-3-pro-image-preview"
            self._textGenDefaultConfig = {
                "response_mime_type": "application/json",
                "thinking_config": types.ThinkingConfig(
                    include_thoughts=False, thinking_level="high"
                ),
            }
            # Ref. SDK can only image as PNG.
            # https://googleapis.github.io/python-genai/genai.html#genai.types.ImageConfig.output_mime_type
            # example code uses only PNG. https://ai.google.dev/gemini-api/docs/image-generation
            self._imgGenConfig = types.ImageConfig(
                aspect_ratio="16:9",
                image_size="2K",
            )
        else:
            # develop
            self._textGenModel = "gemini-2.5-flash-lite"
            self._imgGenModel = "gemini-2.5-flash-image"
            self._textGenDefaultConfig = {
                "response_mime_type": "application/json",
            }
            self._imgGenConfig = types.ImageConfig(aspect_ratio="16:9")

    @override
    def get_status(self) -> str:
        input = "Hello"
        status = ""
        try:
            self._client.models.generate_content(
                model=self._statusCheckModel,
                contents=input,
            )
            #  If response is returned, API is considered available.
            status = "Gemini API is operational"
        except Exception:
            status = "Failed to get Gemini API status."

        # Log
        line = """
========================================
Gemini Status: {}
========================================
""".format(status)
        self._logger.debug(line)

        return {"status": status}

    @override
    def generate_diagram(self, diagram_type: str, diagram_prompt: dict) -> str:
        prompt = self._promptProvider.get_writing_task1_generate_diagram_input(
            diagram_type,
            diagram_prompt["prompt"],
            diagram_prompt["diagram_description"],
        )

        response = self._client.models.generate_content(
            model=self._imgGenModel,
            contents=prompt,
            config=types.GenerateContentConfig(
                # Return image only
                response_modalities=["Image"],
                # https://ai.google.dev/gemini-api/docs/image-generation?_gl=1*ztfrxi*_up*MQ..*_ga*NTczODkzNTM2LjE3NzE4MTQ1NDE.*_ga_P1DBVKWT6V*czE3NzE4MTQ1NDEkbzEkZzAkdDE3NzE4MTQ1NDEkajYwJGwwJGgxMzI4MTIwNjI3#aspect_ratios_and_image_size
                image_config=self._imgGenConfig,
            ),
        )

        for part in response.parts:
            if (
                part.inline_data is not None
                and part.inline_data.data is not None
            ):
                img_data_b64 = base64.b64encode(part.inline_data.data).decode(
                    "utf-8"
                )

        # Log
        log_resp = "Base64 encoded length: {}".format(len(img_data_b64))
        self._write_image_prompt_log(input=prompt, resp=log_resp)

        return img_data_b64

    @override
    def generate_text(
        self,
        instructions: str,
        input: str,
        response_schema: type[BaseModel],
        previous_prompt_id: str | None = None,
    ) -> tuple[str, str]:
        contents = []

        if previous_prompt_id is not None:
            previous_contents = json.loads(previous_prompt_id)
            for pc in previous_contents["contents"]:
                contents.append(
                    types.Content(
                        role=pc["role"],
                        parts=[types.Part(text=pc["text"])],
                    )
                )

        contents.append(
            types.Content(
                role="user",
                parts=[types.Part(text=input)],
            )
        )

        config_args = self._textGenDefaultConfig | {
            "system_instruction": instructions,
            "response_schema": response_schema,
        }
        config = types.GenerateContentConfig(**config_args)

        response = self._client.models.generate_content(
            model=self._textGenModel,
            contents=contents,
            config=config,
        )

        contents.append(
            types.Content(
                role="model",
                parts=[types.Part(text=response.text)],
            )
        )

        self._write_prompt_log(
            instructions=instructions,
            input=input,
            response=response.parsed,
        )

        # Use JSON-formatted string of previous content as prompt ID.
        prompt_id = {
            "contents": [
                {"role": c.role, "text": c.parts[0].text} for c in contents
            ]
        }

        return response.parsed, json.dumps(prompt_id)

    @override
    def get_ai_name(self) -> str:
        return "Gemini"

    @override
    def get_image_api_name(self) -> str:
        return "Image API"

    # -----------------------------------------------------------------------------
    # privates

    def _write_prompt_log(self, instructions: str, input: str, response: any):
        """Output debug log."""

        resp = "No Response"
        if response:
            values = []
            for k, v in response.model_dump().items():
                values.append("- {}: {}".format(k, v))
            resp = format("\n".join(values))

        line = """
========================================
Gemini Instructions ({env}):
{}

------------------------------
Gemini Prompt ({env}):
{}

------------------------------
Gemini Response ({env}):
{}
========================================
""".format(instructions.strip(), input.strip(), resp.strip(), env=settings.env)

        self._logger.debug(line)

    def _write_image_prompt_log(self, input: str, resp: str):
        """Output debug log for image generating."""
        line = """
========================================
Gemini Prompt (Image generating) ({env}):
{}

------------------------------
Gemini Response ({env}):
{}
========================================
""".format(input.strip(), resp.strip(), env=settings.env)

        self._logger.debug(line)
