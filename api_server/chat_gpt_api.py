from typing import override
from flask import Flask
import requests

from pydantic import BaseModel
from openai import OpenAI

from ai_api_proxy import AiApiProxy
from prompt_provider import PromptProvider
from settings import settings


class ChatGptApi(AiApiProxy):
    """An implementation class to provide ChatGPT agent features.
    For details about methods, see `AiApiProxy`."""

    def __init__(self, app: Flask):
        self.client = OpenAI(api_key=settings.openai_api_key)
        self._logger = app.logger
        self._promptProvider = PromptProvider(app)
        self._model = ""
        self._statusCheckModel = "gpt-5-nano"
        if settings.env == "production":
            # production
            self._textGenArgs = {
                "model": "gpt-5",
                # "model": "gpt-4o",
                "temperature": 0.6,
                "top_p": 0.9,
            }
            self._imgGenArgs = {
                "model": "gpt-image-1.5",
                "quality": "high",
                "size": "1536x1024",
                "n": 1,
                "output_format": "jpeg",
                "output_compression": 100,
            }
        else:
            # develop
            self._textGenArgs = {
                "model": "gpt-5-nano",
            }
            self._imgGenArgs = {
                "model": "gpt-image-1-mini",
                "quality": "high",
                "size": "1536x1024",
                "n": 1,
                "output_format": "jpeg",
                "output_compression": 100,
            }

    @override
    def get_status(self) -> str:
        input = "Hello"
        status = ""
        try:
            self.client.responses.parse(
                model=self._statusCheckModel,
                input=input,
            )
            #  If response is returned, API is considered available.
            status = "ChatGPT API is operational"
        except Exception:
            status = self._get_status_from_status_page()

        # Log
        line = """
========================================
ChatGPT Status: {}
========================================
""".format(status)
        self._logger.debug(line)

        return {"status": status}

    @override
    def generate_diagram(self, diagram_type: str, diagram_prompt: dict) -> str:
        # Generate prompt to generate image
        prompt = self._promptProvider.get_writing_task1_generate_diagram_input(
            diagram_type,
            diagram_prompt["prompt"],
            diagram_prompt["diagram_description"],
        )

        # Generate image
        args = self._imgGenArgs | {
            "prompt": prompt,
        }
        result = self.client.images.generate(**args)

        # Log
        log_resp = "Base64 encoded length: {}".format(
            len(result.data[0].b64_json)
        )
        self._write_image_prompt_log(input=prompt, resp=log_resp)

        return result.data[0].b64_json

    @override
    def generate_text(
        self,
        instructions: str,
        input: str,
        response_schema: type[BaseModel],
        previous_prompt_id: str | None = None,
    ) -> tuple[str, str]:
        args = self._textGenArgs | {
            # reasoning: {"effort": "medium"}
            "instructions": instructions,
            "input": input,
            "text_format": response_schema,
        }

        if previous_prompt_id is not None:
            args |= {
                "previous_response_id": previous_prompt_id,
            }

        response = self.client.responses.parse(**args)

        self._write_prompt_log(
            instructions=instructions,
            input=input,
            response=response.output_parsed,
        )

        return response.output_parsed, response.id

    @override
    def get_ai_name(self) -> str:
        return "Chat GPT"

    @override
    def get_image_api_name(self) -> str:
        return "Image API"

    # -----------------------------------------------------------------------------
    # privates

    def _get_status_from_status_page() -> str:
        """Get ChatGPT API status from status page.

        Returns:
            str: ChatGPT API status.
        """
        try:
            response = requests.get(
                "https://status.openai.com/api/v2/status.json", timeout=10
            )
            if response.status_code == 200:
                data = response.json()
                return data["status"]["description"]

        except Exception:
            status = "Failed to get ChatGPT API status."

        return status

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
ChatGPT Instructions ({env}):
{}

------------------------------
ChatGPT Prompt ({env}):
{}

------------------------------
ChatGPT Response ({env}):
{}
========================================
""".format(instructions.strip(), input.strip(), resp.strip(), env=settings.env)

        self._logger.debug(line)

    def _write_image_prompt_log(self, input: str, resp: str):
        """Output debug log for image generating."""
        line = """
========================================
ChatGPT Prompt (Image generating) ({env}):
{}

------------------------------
ChatGPT Response ({env}):
{}
========================================
""".format(input.strip(), resp.strip(), env=settings.env)

        self._logger.debug(line)
