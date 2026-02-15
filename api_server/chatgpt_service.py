import base64
import time

from openai import OpenAI
from pydantic import BaseModel


class ChatGptService:
    """A service class to generate prompts and evaluate user's answers for
    IELTS Writing and Specaking practice using Chat GPT API"""

    def __init__(self, logger):
        self.client = OpenAI()
        self._logger = logger

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

        instructions = """
You are an test item writer for IELTS.
Output three distinct topics that must be in different domian and must not overlap in the same subject.

Constraints on the topics:
- Output a topic as one noun word.
- Output topics that are enabled to use IELTS Writing tasks and Speaking parts.
- Each topic must be as different as possible in domains.

Constraints on the output format:
- Put the topic 1 into the 'topic1' field.
- Put the topic 2 into the 'topic2' field.
- Put the topic 3 into the 'topic3' field.

Constraints on the input exclude topics:
Exclude: <topic 1>,<topic 2>,...
""".strip()

        input = """
Output three topics based on the instructions.

Exclude: {}
""".strip().format(",".join(exclude_topics))

        class Response(BaseModel):
            topic1: str
            topic2: str
            topic3: str

        _, parsed_response = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
        )

        topics = [
            parsed_response.topic1,
            parsed_response.topic2,
            parsed_response.topic3,
        ]
        topics = [s.lower() for s in topics]
        return topics[0:count]

    def generate_writing_task1_prompt(
        self, diagram_type: str, topics: list[str]
    ) -> dict:
        """Generate Writing Task 1 prompt.

        Args:
            diagram_type: Type of diagram to be generated.
            topics: List of topics to include in prompt.

        Returns:
            Generated prompt components:
                - topics (list): List of topics used in generating prompt.
                - introduction (str): Introduction sentence put before diagram.
                - diagram_description (str): Description of diagram.
                - diagram_data (str): Base64 encoded string of diagram.
        """
        # Generate prompt for a diagram.
        img_prompt = self._generate_writing_task1_digram_prompt(
            diagram_type, topics
        )

        # Generate a diagram image.
        img_b64 = self._generate_diagram(diagram_type, img_prompt)

        return {
            "topics": topics,
            "introduction": img_prompt["introduction"],
            "diagram_description": img_prompt["diagram_description"],
            "diagram_data": img_b64,
        }

    def generate_writing_task2_prompt(
        self, essay_type: str, topics: list[str]
    ) -> dict:
        """Generate Writing Task 2 prompt.

        Args:
            essay_type: Type of essay.
            topics: Topics for essay.

        Returns:
            Generated prompt components:
                - topics (list): List of topics used in generating prompt.
                - statement (str): Statement sentence including topics.
                - instruction (str): Instruction for statement.
        """
        instructions = """
You are an test item writer for IELTS Writing Task 2.
You must output two distinct parts of the prompt for IELTS Writing Task 2, a statement and an instruction.
Do not include labels like "Statement:" and "Topic:".
Do not include introductory remarks like "Here is your prompt:".

You must output exactly two element for a structured output.

Put the statement into 'statement' field.
Put the instruction into 'instruction' field.

Each part is as follows:

Statement:
- Include the situational background and viewpoints.
- The number of words must be less than 40 words.
- Do not include instruction in a statement.
- Do not describe the essay type name like "This is a discussion essay...".
- Do not include introductory phrases like "In this essay..." or "Examine the debate...".
- Do not combine multiple clauses using a semicolon.
- Use only declarative sentences that describe the topic.

Instruction:
- The specific task or question for the examinee.
- The number of words must be less than 15 words.
- The simple one sentence.
- Do not output a long explanation. Keep it concise, about the length of the example provided in input.
- Do not include an "You should spend about 40 minutes..."
- Do not include an instruction such as "Give reasons for your answer..." or "Write at least 250 words."
- Do not combine multiple clauses using a semicolon.
""".strip()

        # TODO: currenty fixed topic.
        input = """
Generate a prompt for IELTS Writing Task 2 practice.

The essay type of a prompt is Discussion Essay.
The topic of a statement is oil.
Use the following expressions as a main base in an instruction, but choose only one variant.
- Compare both and state your preference.
- Discuss both views and give your opinion.
Do not include multiple expressions, use only one expression.
Do not limit to the expressions on the above expressions, but allow to use a variety of expressions with equivalent meanings that may appear in the actual IELTS Writing Task 2.
""".strip()

        class Response(BaseModel):
            statement: str
            instruction: str

        _, parsed_response = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
        )

        return {
            "topics": topics,
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
                - prompt_id (str): ChatGPT prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """
        if part_no == 1:
            prompt = self._generate_speaking_part1_question(topic=topic)
        elif part_no == 3:
            prompt = self._generate_speaking_part3_question(topic=topic)

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
            prompt_id: Previous ChatGPT prompt ID.
            user_reply: User's answer to previous question.

        Returns:
            Generated question components:
                - prompt_id (str): ChatGPT prompt ID to continue interaction.
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

        instructions = """
You are an examiner for IELTS Writing Task 1.
Evaluate the provided answer for Writing Task 1 strictly based on the official IELTS Writing Task 1 Band Descriptors.

Constraints on the evaluation:
- Evaluate based on Task Achievement (TA), Coherence and Cohesion (CC), Lexical Resource (LR), and Grammatical Range and Accuracy (GRA).
- Output a score from 0.0 to 9.0 in 0.5 increments for each criterion.
- Penalize TA if the response is significantly under 150 words.

Constraints on the output format:
- Put the TA score into the 'achievement_score' field.
- Put the CC score into the 'coherence_score' field.
- Put the LR score into the 'lexical_score' field.
- Put the GRA score into the 'grammatical_score' field.
- Put the feedback that praises the good points of the answer in terms of TA criteria into the 'achievement_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of TA criteria into the 'achievement_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of CC criteria into the 'coherence_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of CC criteria into the 'coherence_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of LR criteria into the 'lexical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of LR criteria into the 'lexical_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of GRA criteria into the 'grammatical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of GRA criteria into the 'grammatical_feedback2' field. Output specific examples from the text when suggesting improvements.

Constraints on the given prompt:
- The prompt for the given answer is given as 'prompt: <prompt>.'.

Constraints on the given answer:
- The answer that you must evaluate is given as 'answer: <answer>.'.

Constraints on the given description of the diagram:
- The description of the diagram is given as 'diagram_description: <diagram_description>.'.

Constraints on the given description of the diagram type:
- The diagram type is given as 'diagram_type: <diagram_type>.'.
""".strip()

        input = """
Evaluate the given answer for the given prompt, diagram_type, and diagram of Writing Task 1.

prompt: {}

diagram_type: {}

diagram_description: {}

answer: {}
        """.strip().format(prompt, diagram_type, diagram_description, answer)

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

        _, msg = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
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

        instructions = """
You are an examiner for IELTS Writing Task 2.
Evaluate the provided answer for Writing Task 2 strictly based on the official IELTS Writing Task 2 Band Descriptors.

Constraints on the evaluation:
- Evaluate based on Task Response (TR), Coherence and Cohesion (CC), Lexical Resource (LR), and Grammatical Range and Accuracy (GRA).
- Output a score from 0.0 to 9.0 in 0.5 increments for each criterion.
- Penalize TR if the response is significantly under 250 words.

Constraints on the output format:
- Put the TR score into the 'response_score' field.
- Put the CC score into the 'coherence_score' field.
- Put the LR score into the 'lexical_score' field.
- Put the GRA score into the 'grammatical_score' field.
- Put the feedback that praises the good points of the answer in terms of TR criteria into the 'response_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of TR criteria into the 'response_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of CC criteria into the 'coherence_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of CC criteria into the 'coherence_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of LR criteria into the 'lexical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of LR criteria into the 'lexical_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of GRA criteria into the 'grammatical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of GRA criteria into the 'grammatical_feedback2' field. Output specific examples from the text when suggesting improvements.

Constraints on the given prompt:
- The prompt for the given answer is given as 'prompt: <prompt>.'.

Constraints on the given answer:
- The answer that you must evaluate is given as 'answer: <answer>.'.
""".strip()

        input = """
Evaluate the given answer for the given prompt, diagram_type, and diagram of Writing Task 1.

prompt: {}

answer: {}
        """.strip().format(prompt, answer)

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

        _, msg = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
        )

        return msg

    def evaluate_speaking_part1_answer(
        self,
        script: list[dict[str, str]],
    ) -> dict:
        """Evaluate Speaking Part 1 answer.
        For details, refer to _evaluate_speaking_chat_answer.
        """
        return self._evaluate_speaking_chat_answer(part_no=1, script=script)

    def evaluate_speaking_part3_answer(
        self,
        script: list[dict[str, str]],
    ) -> dict:
        """Evaluate Speaking Part 3 answer.
        For details, refer to _evaluate_speaking_chat_answer.
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

        instructions = """
You are an examiner for IELTS Speaking Part 2.
Evaluate the provided speech script for the provided prompt for Speaking Part 2 strictly based on the official IELTS Speaking Band Descriptors.

Constraints on the evaluation:
- Evaluate based on Coherence (CH), Lexical Resource (LR), and Grammatical Range and Accuracy (GRA) strictly based on the official IELTS Speaking Band Descriptors.
- Do not evaluate the script in term of Fluency.
- Output a score from 0.0 to 9.0 in 0.5 increments for each criterion.

Constraints on the output format:
- Put the CH score into the 'coherence_score' field.
- Put the LR score into the 'lexical_score' field.
- Put the GRA score into the 'grammatical_score' field.
- Put the feedback that praises the good points of the answer in terms of CH criteria into the 'coherence_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of CH criteria into the 'coherence_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of LR criteria into the 'lexical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of LR criteria into the 'lexical_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of GRA criteria into the 'grammatical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of GRA criteria into the 'grammatical_feedback2' field. Output specific examples from the text when suggesting improvements.

Constraints on the input speech script and prompt:
- prompt: <Prompt>

- speech: <Speech>
""".strip()

        input = """
Evaluate the following script based on the instructions.

prompt: {}

speech: {}
        """.strip().format(prompt, speech)

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

        _, msg = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
        )

        return msg

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

        instructions = """
You are an examiner for IELTS Speaking Part {0}.
Evaluate the provided script between the examiner and examinee for Speaking Part {0} strictly based on the official IELTS Speaking Band Descriptors.

Constraints on the evaluation:
- Evaluate based on Coherence (CH), Lexical Resource (LR), and Grammatical Range and Accuracy (GRA) strictly based on the official IELTS Speaking Band Descriptors.
- Do not evaluate the script in term of Fluency.
- Output a score from 0.0 to 9.0 in 0.5 increments for each criterion.

Constraints on the output format:
- Put the CH score into the 'coherence_score' field.
- Put the LR score into the 'lexical_score' field.
- Put the GRA score into the 'grammatical_score' field.
- Put the feedback that praises the good points of the answer in terms of CH criteria into the 'coherence_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of CH criteria into the 'coherence_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of LR criteria into the 'lexical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of LR criteria into the 'lexical_feedback2' field. Output specific examples from the text when suggesting improvements.
- Put the feedback that praises the good points of the answer in terms of GRA criteria into the 'grammatical_feedback1' field.
- Put the feedback that suggests areas for improvement in the answer in terms of GRA criteria into the 'grammatical_feedback2' field. Output specific examples from the text when suggesting improvements.

Constraints on the input script:
- Evaluate the following interaction.
- <Role: Examiner or Examinee>: <Question if the role is examiner, otherwise, Answer>
- (Repeat for all questions)
""".strip().format(part_no)

        interactions = []
        for item in script:
            if item["role"] == "examiner":
                interactions.append("Examiner: {}".format(item["message"]))
            else:
                interactions.append("Examinee: {}".format(item["message"]))

        input = """
Evaluate the following script based on the instructions.

{}
        """.strip().format("\n".join(interactions))

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

        _, msg = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
        )

        return msg

    def _generate_writing_task1_digram_prompt(
        self, diagram_type: str, topics: list[str]
    ) -> dict:
        """Generate ChatGPT prompt to create diagram for Writing Task 1.

        Args:
            diagram_type: Type of diagram.
            topics: Topics to include in diagram.

        Returns:
            Generated prompt components:
                - prompt (str): Prompt to generate diagram.
                - introduction (str): Introduction to be put before diagram.
                - diagram_description (str): Description as text of diagram.
        """
        # TODO: use fixed data currently.
        return {
            "prompt": "Create a clean, publication-ready image of a table diagram illustrating crude oil production. The table should have 4 rows for countries: Saudi Arabia, United States, Russia, China; and 3 columns for years: 2015, 2016, 2017, with a header row reading: Country | 2015 | 2016 | 2017. Include a caption: 'Oil production (mbpd)'. Fill each cell with the values (in million barrels per day) as follows: Saudi Arabia — 2015: 11.0, 2016: 11.2, 2017: 11.4; United States — 2015: 9.4, 2016: 9.3, 2017: 9.1; Russia — 2015: 11.0, 2016: 11.1, 2017: 11.2; China — 2015: 4.2, 2016: 4.0, 2017: 3.9. Ensure numbers are displayed with one decimal place and units (mbpd) are clearly indicated. Use a neutral blue-gray color palette, clear gridlines, and legible typography suitable for IELTS Task 1 practice, with a landscape orientation.",
            "introduction": "The diagram below details the annual crude oil production by four top producers (Saudi Arabia, United States, Russia, and China) for the years 2015–2017.",
            "diagram_description": "The values in the table are, Row: Saudi Arabia; Column: 2015; Value: 11.0; This value represents Saudi Arabia's crude oil production in 2015 in mbpd. Row: Saudi Arabia; Column: 2016; Value: 11.2; This value represents Saudi Arabia's crude oil production in 2016 in mbpd. Row: Saudi Arabia; Column: 2017; Value: 11.4; This value represents Saudi Arabia's crude oil production in 2017 in mbpd. Row: United States; Column: 2015; Value: 9.4; This value represents the United States' crude oil production in 2015 in mbpd. Row: United States; Column: 2016; Value: 9.3; This value represents the United States' crude oil production in 2016 in mbpd. Row: United States; Column: 2017; Value: 9.1; This value represents the United States' crude oil production in 2017 in mbpd. Row: Russia; Column: 2015; Value: 11.0; This value represents Russia's crude oil production in 2015 in mbpd. Row: Russia; Column: 2016; Value: 11.1; This value represents Russia's crude oil production in 2016 in mbpd. Row: Russia; Column: 2017; Value: 11.2; This value represents Russia's crude oil production in 2017 in mbpd. Row: China; Column: 2015; Value: 4.2; This value represents China's crude oil production in 2015 in mbpd. Row: China; Column: 2016; Value: 4.0; This value represents China's crude oil production in 2016 in mbpd. Row: China; Column: 2017; Value: 3.9; This value represents China's crude oil production in 2017 in mbpd.",
        }

    def _generate_diagram(
        self, diagram_type: str, diagram_prompt: dict
    ) -> str:
        """Generate diagram for Writing Task 1.

        Args:
            diagram_type: Type of diagram to be generated.
            diagram_prompt: ChatGPT prompt components:
                - prompt (str): Prompt to generate diagram.
                - diagram_description (str): Description as text of diagram.

        Returns:
            Base64 encoded string of diagram.
        """
        # TEST: use fixed data.
        # with open("./assets/test_w1.png", "rb") as f:
        #     img_bytes = f.read()
        # time.sleep(5)
        # return base64.b64encode(img_bytes).decode("ascii")

        prompt = """
        You are an test item writer for IELTS Writing Task 1. Generate a IELTS-style {} diagram based on a prompt.
        {}
        {}
        """.format(
            diagram_type,
            diagram_prompt["prompt"],
            diagram_prompt["diagram_description"],
        )

        result = self.client.images.generate(
            # model="gpt-image-1-mini",
            model="gpt-image-1",
            prompt=prompt,
            quality="high",
        )

        return result.data[0].b64_json

    def _generate_speaking_part1_question(
        self, topic: str = None, prompt_id: int = None, reply: str = None
    ) -> dict:
        """Generate question for Speaking Part 1.

        Args:
            topic: Topic to include in question. Required for initial question.
            prompt_id: Previous ChatGPT prompt ID. Required for subsequent
                question.
            reply: User's answer to previous question. Required for subsequent
                question.

        Returns:
            Generated question components:
                - prompt_id (str): ChatGPT prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """

        instructions = """
You are an examiner for IELTS Speaking Part 1, and output questions.

Constraints on the output questions:
- You must output exactly one question per response.
- You must generate questions based on the given topic in the input.
- You must output each question sentence into the 'question' field.
- Each question must be personal questions about the examinee's experiences, not for discussion.
- Each question includes only one thing, not including multiple things.
- Do not include more than one interrogative in a sentence.
- Each question must be in line with the examinee's previous replies and be a natural conversation.
- Each question must consist of only one sentence per turn.
- Do not end the session until you have asked the three questions in total.
- Do not make combined questions.
- Never use 'and' or 'or' to combine two things at once.
- Never use 'if' and 'when' to assume issue conditions.
- Do not include greetings or feedback in questions.

Constraints on the output format:
- Put the question sentence into the 'question' field.

Constraints on the given topic:
- The topic for the test is given as 'topic: <topic>.'.
        """.strip()

        class Response(BaseModel):
            question: str

        initial = prompt_id is None

        prompt = {}

        if initial:
            input = """
Start mock test of IELTS Speaking Part 1.
You are the examinar.
Topic: {}.
            """.strip().format(topic)

            response, msg = self._fetch_response(
                instructions=instructions, input=input, text_format=Response
            )
        else:
            response, msg = self._fetch_response(
                instructions=instructions,
                input=reply,
                text_format=Response,
                previous_response_id=prompt_id,
            )

        prompt["prompt_id"] = response.id
        prompt["question"] = msg.question

        return prompt

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
        instructions = """
You are an examiner for IELTS Speaking Part 2.
You must output a Speaking Part 2 Cue Card based on the topic provided in the input.
Topic is provided as 'Topic: <topic>.' 

Non negotiable constraints:
- You must output details of the Speaking Part 2 Cue Card into the five fields: instruction, q1, q2, q3, q4.
- Ensure all fields (instruction, q1, q2, q3, and q4) must maintain tense consistency with the provided topic.
- Use formal expression consistent with official IELTS Speaking test materials.
- You must generate outputs followed by the Field Definitions.

Field Definitions:
- instruction: The sentence indicates that the examinee should explain their experiences about the given topic. The sentence must be easy to answer, without being too specific. You must make the sentence specific enough to include room for q1, q2, q3, and q4 to explain the instruction in detail, but do not include interrogatives words. The sentence must starts with "Describe ...", and include the topic given in the input. The number of words must be less than 20. (e.g., Describe a taffic rule that was introduced in your country and that your thought was a very good idea.)
- q1: The concise interrogative sentence to identify the main subject in instruction. The sentence must start with 'What' or 'Who'. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g.,  what the work of art is)
- q2: The concise interrogative sentence to ask background the main subject in instruction. The sentence must start with 'When' or 'Where'. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g., when you first saw it)
- q3: The concise interrogative sentence to ask the details of the main subject in instruction. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g., what you know about it)
- q4: The concise interrogative sentence to ask the reason why the examinee feel. The sentence must start with 'Why'. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g., why you like it.)
""".strip()

        input = """
Generate details of the Speaking Part 2 Cue Card into the five fields: instruction, q1, q2, q3, q4.
Topic: {}.
        """.strip().format(topic)

        class Response(BaseModel):
            instruction: str
            q1: str
            q2: str
            q3: str
            q4: str

        _, res = self._fetch_response(
            instructions=instructions, input=input, text_format=Response
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
        self, topic: str = None, prompt_id: int = None, reply: str = None
    ) -> dict:
        """Generate question for Speaking Part 3.

        Args:
            topic: Topic to include in question. Required for initial question.
            prompt_id: Previous ChatGPT prompt ID. Required for subsequent
                question.
            reply: User's answer to previous question. Required for subsequent
                question.

        Returns:
            Generated question components:
                - prompt_id (str): ChatGPT prompt ID to continue interaction.
                - question (str): Generated question sentence.
        """
        instructions = """
You are an examiner for IELTS Speaking Part 3, and output questions.

Constraints on the output questions:
- You must output exactly one question per response.
- You must generate questions based on the given topic in the input.
- You must output each question sentence into the 'question' field.
- Questions must be abstract questions in society or people in general, not about the examinee's personal experiences.
- Each question includes only one issue, not including multiple issues.
- Each question must be in line with the examinee's previous replies and be a natural conversation.
- Each question must consist of only one sentence.
- Do not end the session until you have asked the three questions in total.
- Never use 'and' or 'or' to combine two things at once.
- You may use 'if' and 'when' to assume issue conditions.
- Do not include greetings or feedback in questions.

Constraints on the output format:
- Put the question sentence into the 'question' field.

Constraints on the given topic:
- The topic for the test is given as 'topic: <topic>.'.
        """.strip()

        class Response(BaseModel):
            question: str

        initial = prompt_id is None

        prompt = {}

        if initial:
            input = """
Start mock test of IELTS Speaking Part 3.
You are the examinar.
Topic: {}.
            """.strip().format(topic)

            response, msg = self._fetch_response(
                instructions=instructions, input=input, text_format=Response
            )
        else:
            response, msg = self._fetch_response(
                instructions=instructions,
                input=reply,
                text_format=Response,
                previous_response_id=prompt_id,
            )

        prompt["prompt_id"] = response.id
        prompt["question"] = msg.question

        return prompt

    def _fetch_response(
        self,
        instructions: str,
        input: str,
        text_format: type[BaseModel],
        previous_response_id: str | None = None,
    ) -> any:
        """Call ChatGPT response API.

        Args:
            instructions, input, text_format, previouse_response_id:
                Arguments for OpenAI.responses.parse.

        Returns:
            Returns of OpenAI.responses.parse.
        """
        # model="gpt-5-nano",
        model = "gpt-4o"
        # reasoning = {"effort": "medium"}
        temperature = 0.6
        top_p = 0.9
        if previous_response_id is not None:
            response = self.client.responses.parse(
                previous_response_id=previous_response_id,
                model=model,
                # reasoning=reasoning,
                instructions=instructions,
                input=input,
                text_format=text_format,
                # Expanding the range of output expression
                #
                temperature=temperature,
                top_p=top_p,
            )
        else:
            try:
                response = self.client.responses.parse(
                    model=model,
                    # reasoning=reasoning,
                    instructions=instructions,
                    input=input,
                    text_format=text_format,
                    # Expanding the range of output expression
                    # nano does not support temperature
                    temperature=temperature,
                    top_p=top_p,
                )
            except Exception as e:
                print(e)

        self._write_prompt_log(
            instructions=instructions,
            input=input,
            response=response.output_parsed,
        )

        return response, response.output_parsed

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
ChatGPT Instructions:
{}

------------------------------
ChatGPT Prompt:
{}

------------------------------
ChatGPT Response:
{}
========================================
""".format(instructions.strip(), input.strip(), resp.strip())

        self._logger.debug(line)
