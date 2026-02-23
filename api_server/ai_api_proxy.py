from abc import ABC, abstractmethod

from pydantic import BaseModel


class AiApiProxy(ABC):
    """An interface class to proxy AI API.
    Each AI agent, ChatGPT and Gemini, needs to inherit this class.
    """

    @abstractmethod
    def get_status(self) -> str:
        """Return API availability status.

        Returns:
            API availability status.
        """
        pass

    @abstractmethod
    def generate_diagram(self, diagram_type: str, diagram_prompt: dict) -> str:
        """Generate Base64 encoded diagram image bytes as string.

        Args:
            diagram_type: Type of diagram to be generated.
            diagram_prompt: Pompt components:
                - prompt (str): Prompt to generate diagram.
                - diagram_description (str): Diagram description as text.

        Returns:
            Base64 encoded string of diagram.
        """
        pass

    @abstractmethod
    def generate_text(
        self,
        instructions: str,
        input: str,
        response_schema: type[BaseModel],
        previous_prompt_id: str | None = None,
    ) -> tuple[str, str]:
        """Generate text.

        Args:
            instructions: Use as system instructions.
            input: Usse as new user's prompt.
            response_schema: Use as format definition of response.
            previous_prompt_id: ID to represent previous interactions.

        Returns:
            tuple:
                1. Generated text parsed based on response_schema.
                2. Prompt ID representing current interactions.
        """
        pass

    @abstractmethod
    def get_ai_name(self) -> str:
        """Return API agent name."""
        pass

    @abstractmethod
    def get_image_api_name(self) -> str:
        """Return Image API name to generate image."""
        pass
