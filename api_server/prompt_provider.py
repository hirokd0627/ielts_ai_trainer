from flask import Flask


class PromptProvider:
    """A class provides instructions and input text of prompt for generative AI."""

    def __init__(self, app: Flask):
        self._app = app

    def get_topics_instructions(self) -> str:
        """Return instructions used to generate topics."""
        return self._load_file("topics_instructions")

    def get_topics_input(self, exclude_topics: str) -> str:
        """Return input used to generate topics."""
        return self._load_file("topics_input", exclude=exclude_topics)

    def get_writing_task1_generate_diagram_prompt_instructions(
        self, ai_name: str, image_api_name: str
    ) -> str:
        """Return instructions used to generate diagram prompt for Writing Task 1."""
        return self._load_file(
            "writing_1_diagram_instructions",
            ai_name=ai_name,
            image_api_name=image_api_name,
        )

    def get_writing_task1_generate_diagram_prompt_input(
        self, diagram_type: str, topic: str, ai_name: str, image_api_name: str
    ) -> str:
        """Return input used to generate diagram prompt for Writing Task 1."""
        return self._load_file(
            "writing_1_diagram_input",
            diagram_type=diagram_type,
            topic=topic,
            ai_name=ai_name,
            image_api_name=image_api_name,
        )

    def get_writing_task1_generate_diagram_input(
        self,
        diagram_type: str,
        prompt: str,
        diagram_description: str,
    ) -> str:
        """Return instructions used to generate diagram for Writing Task 1."""
        return self._load_file(
            "writing_1_generate_diagram_input",
            diagram_type=diagram_type,
            prompt=prompt,
            diagram_description=diagram_description,
        )

    def get_writing_task1_evaluation_instructions(self) -> str:
        """Return instructions used to evaluate answer for Writing Task 1."""
        return self._load_file("writing_1_evaluation_instructions")

    def get_writing_task1_evaluation_input(
        self,
        prompt: str,
        diagram_type: str,
        diagram_description: str,
        answer: str,
    ) -> str:
        """Return input used to evaluate answer for Writing Task 1."""
        return self._load_file(
            "writing_1_evaluation_input",
            prompt=prompt,
            diagram_type=diagram_type,
            diagram_description=diagram_description,
            answer=answer,
        )

    def get_writing_task2_task_instructions(self) -> str:
        """Return instructions used to generate task content for Writing Task 2."""
        return self._load_file("writing_2_task_instructions")

    def get_writing_task2_task_input(
        self, topic: str, essay_type: str, expression_phrases: str
    ) -> str:
        """Return input used to generate task content for Writing Task 2."""
        return self._load_file(
            "writing_2_task_input",
            topic=topic,
            essay_type=essay_type,
            expression_phrases=expression_phrases,
        )

    def get_writing_task2_evaluation_instructions(self) -> str:
        """Return instructions used to evaluate answer for Writing Task 2."""
        return self._load_file("writing_2_evaluation_instructions")

    def get_writing_task2_evaluation_input(
        self,
        prompt: str,
        answer: str,
    ) -> str:
        """Return input used to evaluate answer for Writing Task 2."""
        return self._load_file(
            "writing_2_evaluation_input", prompt=prompt, answer=answer
        )

    def get_speaking_part1_task_instructions(self) -> str:
        """Return instructions used to generate task content for Speaking Part 1."""
        return self._load_file("speaking_1_task_instructions")

    def get_speaking_part1_task_input(self, topic: str) -> str:
        """Return input used to generate task content for Speaking Part 1."""
        return self._load_file("speaking_1_task_input", topic=topic)

    def get_speaking_part2_task_instructions(self) -> str:
        """Return instructions used to generate task content for Speaking Part 2."""
        return self._load_file("speaking_2_task_instructions")

    def get_speaking_part2_task_input(self, topic: str) -> str:
        """Return input used to generate task content for Speaking Part 2."""
        return self._load_file("speaking_2_task_input", topic=topic)

    def get_speaking_part2_evaluation_instructions(self) -> str:
        """Return instructions used to evaluate answer for Speaking Part 2."""
        return self._load_file("speaking_2_evaluation_instructions")

    def get_speaking_part2_evaluation_input(
        self, prompt: str, speech: str
    ) -> str:
        """Return input used to evaluate answer for Speaking Part 2."""
        return self._load_file(
            "speaking_2_evaluation_input", prompt=prompt, speech=speech
        )

    def get_speaking_chat_evaluation_instructions(self, part_no: str) -> str:
        """Return instructions used to evaluate answer for Speaking Part 1 and 3."""
        return self._load_file(
            "speaking_chat_evaluation_instructions", part_no=part_no
        )

    def get_speaking_chat_evaluation_input(self, interactions: str) -> str:
        """Return input used to evaluate answer for Speaking Part 1 and 3."""
        return self._load_file(
            "speaking_chat_evaluation_input", interactions=interactions
        )

    def get_speaking_part3_task_instructions(self) -> str:
        """Return instructions used to generate task content for Speaking Part 3."""
        return self._load_file("speaking_3_task_instructions")

    def get_speaking_part3_task_input(self, topic: str) -> str:
        """Return input used to generate task content for Speaking Part 3."""
        return self._load_file("speaking_3_task_input", topic=topic)

    def _load_file(self, file_name: str, **kwargs) -> str:
        """Load a file and format it using given kwargs, then return it.

        Args:
            file_name: Fle name to load, no extension.
            **kwargs: Arbitrary keyword arguments to format string of file_name.

        Returns:
            Formatted string.
        """
        with self._app.open_resource(
            "assets/prompts/{}.txt".format(file_name),
            mode="rt",
            encoding="utf-8",
        ) as f:
            content = f.read().strip()
        return content.format(**kwargs) if kwargs else content
