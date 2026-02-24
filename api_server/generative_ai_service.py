from flask import Flask
from pydantic import BaseModel

from ai_api_proxy import AiApiProxy
from prompt_provider import PromptProvider


class GenerativeAiService:
    """A service class to provide generative AI features."""

    def __init__(self, app: Flask, aiApiProxy: AiApiProxy):
        self._logger = app.logger
        self._promptProvider = PromptProvider(app)
        self._aiApi = aiApiProxy

    def generate_topics(
        self, count: int, exclude_topics: list[str]
    ) -> list[str]:
        """Generate topics for prompt generation.

        Args:
            count: Number of topics to generate.
            exclude_topics: Topics to exclude.

        Returns:
            List of generated topics.
        """
        instructions = self._promptProvider.get_topics_instructions()
        capitalized = [t.capitalize() for t in exclude_topics]
        input = self._promptProvider.get_topics_input(",".join(capitalized))

        class Response(BaseModel):
            topic1: str
            topic2: str
            topic3: str

        parsed_response, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        topics = [
            parsed_response.topic1,
            parsed_response.topic2,
            parsed_response.topic3,
        ]
        topics = [s.lower() for s in topics]
        return topics[0:count]

    def generate_writing_task1_prompt(
        self, diagram_type: str, topic: str
    ) -> dict:
        """Generate Writing Task 1 prompt.

        Args:
            diagram_type: Type of diagram to be generated.
            topic: Topic to include in prompt.

        Returns:
            Generated prompt components:
                - introduction (str): Introduction sentence put before diagram.
                - diagram_description (str): Description of diagram.
                - diagram_data (str): Base64 encoded string of diagram.
        """
        # Generate prompt for a diagram.
        img_prompt = self._generate_writing_task1_digram_prompt(
            diagram_type,
            topic,
        )

        # Generate a diagram image.
        img_b64 = self._aiApi.generate_diagram(
            diagram_type.capitalize(), img_prompt
        )

        return {
            "introduction": img_prompt["introduction"],
            "diagram_description": img_prompt["diagram_description"],
            "diagram_data": img_b64,
        }

    def generate_writing_task2_prompt(
        self, essay_type: str, topic: str
    ) -> dict:
        """Generate Writing Task 2 prompt.

        Args:
            essay_type: Type of essay.
            topic: Topic for essay.

        Returns:
            Generated prompt components:
                - statement (str): Statement sentence including topic.
                - instruction (str): Instruction for statement.
        """
        phrases = []
        if essay_type == "discussion":
            essay_type_label = "Discussion Essay"
            phrases.append("Compare both and state your preference.")
            phrases.append("Discuss both views and give your opinion.")

        elif essay_type == "problem_solution":
            essay_type_label = "Problem and Solution"
            phrases.append("What are the causes of this?")
            phrases.append("What are some solutions to this problem?")
            phrases.append("What can be done to solve this problem?")
            phrases.append(
                "What problems may arise from excessive use of these games and how can they be reduced?"
            )

        elif essay_type == "opinion":
            essay_type_label = "Opinion Essay (Agree or Disagree)"
            phrases.append(
                "To what extent do you agree or disagree with this opinion?"
            )
            phrases.append("Do you agree or disagree?")
            phrases.append("Is this a positive or negative development?")
            phrases.append("Should families or the government be responsible?")
            phrases.append("What is your opinion?")

        elif essay_type == "two_part_question":
            essay_type_label = "Two-part Question Essay"
            phrases.append(
                "Do prisons work Should lawbreakers be rehabilitated or punished?"
            )
            phrases.append(
                "To what extent do you agree and what changes would you like to see?"
            )
            phrases.append("What ... and Why ...?")

        elif essay_type == "advantage_and_disadvantage":
            essay_type_label = "Advantages and Disadvantages"
            phrases.append("Is this a positive or negative development?")
            phrases.append("Discuss the advantages and disadvantages.")
            phrases.append("Discuss the pros and cons.")
            phrases.append("Do the advantages outweigh the disadvantages?")
            phrases.append("What are the pros and cons of this development?")

        expression_phrases = "- " + "\n* ".join(phrases)

        instructions = (
            self._promptProvider.get_writing_task2_task_instructions()
        )
        input = self._promptProvider.get_writing_task2_task_input(
            essay_type=essay_type_label,
            topic=topic.capitalize(),
            expression_phrases=expression_phrases,
        )

        class Response(BaseModel):
            statement: str
            instruction: str

        parsed_response, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return {
            "statement": parsed_response.statement,
            "instruction": parsed_response.instruction,
        }

    def generate_speaking_initial_question(
        self, part_no: int, topic: str
    ) -> dict:
        """Generate initial question for Speaking Part 1 and Part 3.

        Args:
            part_no: Speaking Part number to generate.
            topic: Topic to include in question.

        Returns:
            Generated question components:
                - prompt_id (str): Prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """
        if part_no == 1:
            prompt = self._generate_speaking_part1_question(
                topic=topic,
            )
        elif part_no == 3:
            prompt = self._generate_speaking_part3_question(
                topic=topic,
            )

        return {
            "prompt_id": prompt["prompt_id"],
            "question": prompt["question"],
        }

    def generate_speaking_subsequent_question(
        self, part_no: int, prompt_id: str, user_reply: str
    ) -> dict:
        """Generate subsequent question for Speaking Part 1 and Part 3.

        Args:
            part_no: Speaking Part number to generate.
            prompt_id: Previous prompt ID.
            user_reply: User's answer to previous question.

        Returns:
            Generated question components:
                - prompt_id (str): Prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """
        if part_no == 1:
            prompt = self._generate_speaking_part1_question(
                prompt_id=prompt_id, reply=user_reply
            )
        elif part_no == 3:
            prompt = self._generate_speaking_part3_question(
                prompt_id=prompt_id, reply=user_reply
            )

        return {
            "prompt_id": prompt["prompt_id"],
            "question": prompt["question"],
        }

    def evaluate_writing_task1_answer(
        self,
        prompt: str,
        diagram_type: str,
        diagram_description: str,
        answer: str,
    ) -> dict:
        """Evaluate Writing Task 1 answer.

        Args:
            prompt: Prompt sentences.
            diagram_type: Type of diagram to be generated.
            diagram_description: Description of diagram
            answer: User's answer

        Returns:
            Evaluation components:
                - achievement_score (float): Task Achievement score.
                - coherence_score (float): Coherence and Cohesion score.
                - grammatical_score (float): Grammatical Range and Accuracy score.
                - lexical_score (float): Lexical Resource score.
                - achievement_feedback1 (str): Positive feedback for Task Achievement.
                - achievement_feedback2 (str): Areas for improvement for Task Achievement.
                - coherence_feedback1 (str): Positive feedback for Coherence and Cohesion.
                - coherence_feedback2 (str): Areas for improvement for Coherence and Cohesion.
                - grammatical_feedback1 (str): Positive feedback for Grammatical Range and Accuracy.
                - grammatical_feedback2 (str): Areas for improvement for Grammatical Range and Accuracy.
                - lexical_feedback1 (str): Positive feedback for Lexical Resource.
                - lexical_feedback2 (str): Areas for improvement for Lexical Resource.
        """
        instructions = (
            self._promptProvider.get_writing_task1_evaluation_instructions()
        )
        input = self._promptProvider.get_writing_task1_evaluation_input(
            prompt=prompt,
            diagram_type=diagram_type.capitalize(),
            diagram_description=diagram_description,
            answer=answer,
        )

        class Response(BaseModel):
            achievement_score: float
            coherence_score: float
            grammatical_score: float
            lexical_score: float
            achievement_feedback1: str
            achievement_feedback2: str
            coherence_feedback1: str
            coherence_feedback2: str
            grammatical_feedback1: str
            grammatical_feedback2: str
            lexical_feedback1: str
            lexical_feedback2: str

        msg, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return msg

    def evaluate_writing_task2_answer(
        self,
        prompt: str,
        answer: str,
    ) -> dict:
        """Evaluate Writing Task 2 answer.

        Args:
            prompt: Prompt sentences.
            answer: User's answer

        Returns:
            Evaluation components:
                - response_score (float): Task Response score.
                - coherence_score (float): Coherence and Cohesion score.
                - grammatical_score (float): Grammatical Range and Accuracy score.
                - lexical_score (float): Lexical Resource score.
                - response_feedback1 (str): Positive feedback for Task Response.
                - response_feedback2 (str): Areas for improvement for Task Response.
                - coherence_feedback1 (str): Positive feedback for Coherence and Cohesion.
                - coherence_feedback2 (str): Areas for improvement for Coherence and Cohesion.
                - grammatical_feedback1 (str): Positive feedback for Grammatical Range and Accuracy.
                - grammatical_feedback2 (str): Areas for improvement for Grammatical Range and Accuracy.
                - lexical_feedback1 (str): Positive feedback for Lexical Resource.
                - lexical_feedback2 (str): Areas for improvement for Lexical Resource.
        """
        instructions = (
            self._promptProvider.get_writing_task2_evaluation_instructions()
        )
        input = self._promptProvider.get_writing_task2_evaluation_input(
            prompt=prompt, answer=answer
        )

        class Response(BaseModel):
            response_score: float
            coherence_score: float
            grammatical_score: float
            lexical_score: float
            response_feedback1: str
            response_feedback2: str
            coherence_feedback1: str
            coherence_feedback2: str
            grammatical_feedback1: str
            grammatical_feedback2: str
            lexical_feedback1: str
            lexical_feedback2: str

        msg, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return msg

    def evaluate_speaking_part1_answer(
        self,
        script: list[dict[str, str]],
    ) -> dict:
        """Evaluate Speaking Part 1 answer.

        Args:
            script: List of turns in conversation.
                Each dict contains:
                    - examiner (str): Question asked.
                    - examinee (str): examinee's response to question.

        Returns:
            Evaluation components:
                - coherence_score (float): Coherence score.
                - lexical_score (float): Lexical Resource score.
                - grammatical_score (float): Grammatical Range and Accuracy score.
                - coherence_feedback1 (str): Positive feedback for Coherence.
                - coherence_feedback2 (str): Areas for improvement for Coherence.
                - grammatical_feedback1 (str): Positive feedback for Grammatical Range and Accuracy.
                - grammatical_feedback2 (str): Areas for improvement for Grammatical Range and Accuracy.
                - lexical_feedback1 (str): Positive feedback for Lexical Resource.
                - lexical_feedback2 (str): Areas for improvement for Lexical Resource.
        """
        return self._evaluate_speaking_chat_answer(part_no=1, script=script)

    def evaluate_speaking_part3_answer(
        self,
        script: list[dict[str, str]],
    ) -> dict:
        """Evaluate Speaking Part 3 answer.

        Args:
            script: List of turns in conversation.
                Each dict contains:
                    - examiner (str): Question asked.
                    - examinee (str): examinee's response to question.

        Returns:
            Evaluation components:
                - coherence_score (float): Coherence score.
                - lexical_score (float): Lexical Resource score.
                - grammatical_score (float): Grammatical Range and Accuracy score.
                - coherence_feedback1 (str): Positive feedback for Coherence.
                - coherence_feedback2 (str): Areas for improvement for Coherence.
                - grammatical_feedback1 (str): Positive feedback for Grammatical Range and Accuracy.
                - grammatical_feedback2 (str): Areas for improvement for Grammatical Range and Accuracy.
                - lexical_feedback1 (str): Positive feedback for Lexical Resource.
                - lexical_feedback2 (str): Areas for improvement for Lexical Resource.
        """
        return self._evaluate_speaking_chat_answer(part_no=3, script=script)

    def evaluate_speaking_part2_answer(
        self,
        prompt: str,
        speech: str,
    ) -> dict:
        """Evaluate Speaking Part 2 answer.

        Args:
            prompt: Speaking Part 2 prompt.
            speech: User's answer.

        Returns:
            Evaluation components:
                - coherence_score (float): Coherence score.
                - lexical_score (float): Lexical Resource score.
                - grammatical_score (float): Grammatical Range and Accuracy score.
                - coherence_feedback1 (str): Positive feedback for Coherence.
                - coherence_feedback2 (str): Areas for improvement for Coherence.
                - grammatical_feedback1 (str): Positive feedback for Grammatical Range and Accuracy.
                - grammatical_feedback2 (str): Areas for improvement for Grammatical Range and Accuracy.
                - lexical_feedback1 (str): Positive feedback for Lexical Resource.
                - lexical_feedback2 (str): Areas for improvement for Lexical Resource.
        """
        instructions = (
            self._promptProvider.get_speaking_part2_evaluation_instructions()
        )
        input = self._promptProvider.get_speaking_part2_evaluation_input(
            prompt, speech
        )

        class Response(BaseModel):
            coherence_score: float
            lexical_score: float
            grammatical_score: float
            coherence_feedback1: str
            coherence_feedback2: str
            lexical_feedback1: str
            lexical_feedback2: str
            grammatical_feedback1: str
            grammatical_feedback2: str

        msg, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return msg

    def get_status(self) -> str:
        """Get API availability status.

        Returns:
            dict: Availability status information.
                - status (str): String to represent API availability.
        """
        return self._aiApi.get_status()

    # ------------------------------------------------------------------------
    # privates

    def _evaluate_speaking_chat_answer(
        self,
        part_no: int,
        script: list[dict[str, str]],
    ) -> dict:
        """Evaluate Speaking Part 1 and Part 3 answer.

        Args:
            part_no: Speaking Part number to evaluate.
            script: List of turns in conversation.
                Each dict contains:
                    - examiner (str): Question asked.
                    - examinee (str): examinee's response to question.

        Returns:
            Evaluation components:
                - coherence_score (float): Coherence score.
                - lexical_score (float): Lexical Resource score.
                - grammatical_score (float): Grammatical Range and Accuracy score.
                - coherence_feedback1 (str): Positive feedback for Coherence.
                - coherence_feedback2 (str): Areas for improvement for Coherence.
                - grammatical_feedback1 (str): Positive feedback for Grammatical Range and Accuracy.
                - grammatical_feedback2 (str): Areas for improvement for Grammatical Range and Accuracy.
                - lexical_feedback1 (str): Positive feedback for Lexical Resource.
                - lexical_feedback2 (str): Areas for improvement for Lexical Resource.
        """
        instructions = (
            self._promptProvider.get_speaking_chat_evaluation_instructions(
                part_no
            )
        )

        interactions = []
        for item in script:
            if item["role"] == "examiner":
                interactions.append("Examiner: {}".format(item["message"]))
            else:
                interactions.append("Examinee: {}".format(item["message"]))

        input = self._promptProvider.get_speaking_chat_evaluation_input(
            "\n".join(interactions)
        )

        class Response(BaseModel):
            coherence_score: float
            lexical_score: float
            grammatical_score: float
            coherence_feedback1: str
            coherence_feedback2: str
            lexical_feedback1: str
            lexical_feedback2: str
            grammatical_feedback1: str
            grammatical_feedback2: str

        msg, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return msg

    def _generate_writing_task1_digram_prompt(
        self, diagram_type: str, topic: str
    ) -> dict:
        """Generate prompt to create diagram for Writing Task 1.

        Args:
            diagram_type: Type of diagram.
            topic: Topic to include in diagram.

        Returns:
            Generated prompt components:
                - prompt (str): Prompt to generate diagram.
                - introduction (str): Introduction to be put before diagram.
                - diagram_description (str): Description as text of diagram.
        """
        instructions = self._promptProvider.get_writing_task1_generate_diagram_prompt_instructions(
            ai_name=self._aiApi.get_ai_name(),
            image_api_name=self._aiApi.get_image_api_name(),
        )
        input = self._promptProvider.get_writing_task1_generate_diagram_prompt_input(
            diagram_type=diagram_type.capitalize(),
            topic=topic.capitalize(),
            ai_name=self._aiApi.get_ai_name(),
            image_api_name=self._aiApi.get_image_api_name(),
        )

        class Response(BaseModel):
            prompt: str
            introduction: str
            diagram_description: str

        msg, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return {
            "prompt": msg.prompt,
            "introduction": msg.introduction,
            "diagram_description": msg.diagram_description,
        }

    def _generate_speaking_part1_question(
        self, topic: str = None, prompt_id: str = None, reply: str = None
    ) -> dict:
        """Generate question for Speaking Part 1.

        Args:
            topic: Topic to include in question. Required for initial question.
            prompt_id: Previous prompt ID. Required for subsequent
                question.
            reply: User's answer to previous question. Required for subsequent
                question.

        Returns:
            Generated question components:
                - prompt_id (str): Prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """
        instructions = (
            self._promptProvider.get_speaking_part1_task_instructions()
        )

        class Response(BaseModel):
            question: str

        args = {
            "instructions": instructions,
            "response_schema": Response,
        }

        if prompt_id is None:  # initial
            args["input"] = self._promptProvider.get_speaking_part1_task_input(
                topic.capitalize()
            )
        else:
            args["input"] = reply
            args["previous_prompt_id"] = prompt_id

        msg, prompt_id = self._aiApi.generate_text(**args)

        return {
            "prompt_id": prompt_id,
            "question": msg.question,
        }

    def generate_speaking_part2_cuecard(self, topic: str) -> dict:
        """Generate Cue card content for Speaking Part 2.

        Args:
            topic: Topic for cue card.

        Returns:
            Generated cue card content:
                - instruction (str): Main instruction to describe.
                - q1 (str): First question for task.
                - q2 (str): Second question for task.
                - q3 (str): Third question for task.
                - q4 (str): Fourth question for task.
        """
        instructions = (
            self._promptProvider.get_speaking_part2_task_instructions()
        )
        input = self._promptProvider.get_speaking_part2_task_input(
            topic=topic.capitalize()
        )

        class Response(BaseModel):
            instruction: str
            q1: str
            q2: str
            q3: str
            q4: str

        res, _ = self._aiApi.generate_text(
            instructions=instructions, input=input, response_schema=Response
        )

        return {
            "topic": topic,
            "instruction": res.instruction,
            "q1": res.q1,
            "q2": res.q2,
            "q3": res.q3,
            "q4": res.q4,
        }

    def _generate_speaking_part3_question(
        self, topic: str = None, prompt_id: str = None, reply: str = None
    ) -> dict:
        """Generate question for Speaking Part 3.

        Args:
            topic: Topic to include in question. Required for initial question.
            prompt_id: Previous prompt ID. Required for subsequent
                question.
            reply: User's answer to previous question. Required for subsequent
                question.

        Returns:
            Generated question components:
                - prompt_id (str): Prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """
        instructions = (
            self._promptProvider.get_speaking_part3_task_instructions()
        )

        class Response(BaseModel):
            question: str

        args = {
            "instructions": instructions,
            "response_schema": Response,
        }

        if prompt_id is None:  # initial
            args["input"] = self._promptProvider.get_speaking_part3_task_input(
                topic.capitalize()
            )
        else:
            args["input"] = reply
            args["previous_prompt_id"] = prompt_id

        msg, prompt_id = self._aiApi.generate_text(**args)

        return {
            "prompt_id": prompt_id,
            "question": msg.question,
        }
