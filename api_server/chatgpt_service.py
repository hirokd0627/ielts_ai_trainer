import base64
import time
from tkinter import W

from openai import OpenAI
from pydantic import BaseModel


class ChatGptService:
    """A service class to generate prompt and evaluate answers for IELTS
    Writing and Specaking practice using Chat GPT API"""

    def __init__(self):
        self.client = OpenAI()

    def generate_topics(self, count: int) -> list[str]:
        """Generates topics to use prompt generation.

        Args:
            count (int): The number of topics to generate.

        Returns:
            List[str]: The list of topics.
        """
        # curretly use fixed prompt
        dummy = ["oil", "home", "food"]
        return dummy[0:count]

    def generate_writing_task1_prompt(
        self, diagram_type: str, topics: list[str]
    ) -> dict:
        """Generates prompt for Writing Task 2.

        Args:
            diagram_type (str): Type of diagram.
            topics (str): Topic of question.

        Returns:
            Dict[str, str]: Generated prompt parts.
                - 'topics (list)': The list of topics to used in generating
                    prompt.
                - 'introduction' (str): Introduction sentence put before
                    a diagram.
                - 'diagram_description' (str): Description of a diagram.
                - 'diagram_data' (str): Base64 encoded bytes of a diagram.
        """
        # Generates prompt for a diagram.
        img_prompt = self._generate_writing_task1_digram_prompt(diagram_type, topics)

        # Generates a diagram image.
        img_b64 = self._generate_diagram(diagram_type, img_prompt)

        return {
            "topics": topics,
            "introduction": img_prompt["introduction"],
            "diagram_description": img_prompt["diagram_description"],
            "diagram_data": img_b64,
        }

    def generate_writing_task2_prompt(self, essay_type: str, topics: list[str]) -> dict:
        """Generates prompt for Writing Task 2.

        Args:
            essay_type (str): Type of essay.
            topic (str): Topic of question.

        Returns:
            Dict[str, str]: Generated prompt parts.
                - 'topics (list)': The list of topics to used in generating
                    prompt.
                - 'statement' (str): Statement sentence including topics.
                - 'instruction' (str): Dommand for statement.
        """
        # generate prompt
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
"""

        input = """
Generate a prompt for IELTS Writing Task 2 practice.

The essay type of a prompt is Discussion Essay.
The topic of a statement is oil.
Use the following expressions as a main base in an instruction, but choose only one variant.
- Compare both and state your preference.
- Discuss both views and give your opinion.
Do not include multiple expressions, use only one expression.
Do not limit to the expressions on the above expressions, but allow to use a variety of expressions with equivalent meanings that may appear in the actual IELTS Writing Task 2.
"""

        class Prompt(BaseModel):
            statement: str
            instruction: str

        response = self.client.responses.parse(
            model="gpt-5-nano",
            reasoning={"effort": "medium"},
            instructions=instructions,
            input=input,
            text_format=Prompt,
            # Expanding the range of output expression
            # nano does not support temperature
            # temperature=0.6,
            # top_p= 0.9,
        )
        prompt = response.output_parsed

        return {
            "topics": topics,
            "statement": prompt.statement,
            "instruction": prompt.instruction,
        }

    def generate_speaking_initial_question(self, part_no: int, topic: str) -> dict:
        """TODO"""
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
        """TODO"""
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

    def _generate_writing_task1_digram_prompt(
        self, diagram_type: str, topics: list[str]
    ) -> dict:
        """Generates the prompt for generating a diagram image for Writing Task 1.

        Args:
            diagram_type (str): Type of diagram.
            topics (str): Topic of question.

        Returns:
            Dict[str, str]: Generated prompt parts.
                - 'prompt': Prompt for generating a diagram.
                - 'introduction' (str): Introduction put before
                    a diagram.
                - 'diagram_description' (str): Description as text for
                    a diagram.
        """
        # NOTE: curretly use fixed prompt
        return {
            "prompt": "Create a clean, publication-ready image of a table diagram illustrating crude oil production. The table should have 4 rows for countries: Saudi Arabia, United States, Russia, China; and 3 columns for years: 2015, 2016, 2017, with a header row reading: Country | 2015 | 2016 | 2017. Include a caption: 'Oil production (mbpd)'. Fill each cell with the values (in million barrels per day) as follows: Saudi Arabia — 2015: 11.0, 2016: 11.2, 2017: 11.4; United States — 2015: 9.4, 2016: 9.3, 2017: 9.1; Russia — 2015: 11.0, 2016: 11.1, 2017: 11.2; China — 2015: 4.2, 2016: 4.0, 2017: 3.9. Ensure numbers are displayed with one decimal place and units (mbpd) are clearly indicated. Use a neutral blue-gray color palette, clear gridlines, and legible typography suitable for IELTS Task 1 practice, with a landscape orientation.",
            "introduction": "The diagram below details the annual crude oil production by four top producers (Saudi Arabia, United States, Russia, and China) for the years 2015–2017.",
            "diagram_description": "The values in the table are, Row: Saudi Arabia; Column: 2015; Value: 11.0; This value represents Saudi Arabia's crude oil production in 2015 in mbpd. Row: Saudi Arabia; Column: 2016; Value: 11.2; This value represents Saudi Arabia's crude oil production in 2016 in mbpd. Row: Saudi Arabia; Column: 2017; Value: 11.4; This value represents Saudi Arabia's crude oil production in 2017 in mbpd. Row: United States; Column: 2015; Value: 9.4; This value represents the United States' crude oil production in 2015 in mbpd. Row: United States; Column: 2016; Value: 9.3; This value represents the United States' crude oil production in 2016 in mbpd. Row: United States; Column: 2017; Value: 9.1; This value represents the United States' crude oil production in 2017 in mbpd. Row: Russia; Column: 2015; Value: 11.0; This value represents Russia's crude oil production in 2015 in mbpd. Row: Russia; Column: 2016; Value: 11.1; This value represents Russia's crude oil production in 2016 in mbpd. Row: Russia; Column: 2017; Value: 11.2; This value represents Russia's crude oil production in 2017 in mbpd. Row: China; Column: 2015; Value: 4.2; This value represents China's crude oil production in 2015 in mbpd. Row: China; Column: 2016; Value: 4.0; This value represents China's crude oil production in 2016 in mbpd. Row: China; Column: 2017; Value: 3.9; This value represents China's crude oil production in 2017 in mbpd.",
        }

    def _generate_diagram(self, question_type: str, img_prompt: dict) -> str:
        """Generates a diagram image for Writing Task 1.

        Args:
            question_type (str): Type of question.
            image_prompt (dict): Prompt to generate an image.
                - 'prompt': Prompt for generating a diagram.
                - 'diagram_description' (str): Description as text for
                    a diagram.

        Returns:
            str: Base64 encoded bytes of a diagram image.
        """
        # Test
        with open("./assets/test_w1.png", "rb") as f:
            img_bytes = f.read()
        time.sleep(5)
        return base64.b64encode(img_bytes).decode("ascii")

        # prompt = """
        # You are an test item writer for IELTS Writing Task 1. Generate a IELTS-style {} diagram based on a prompt.
        # {}
        # {}
        # """.format(question_type, img_prompt['prompt'], img_prompt['dialog_description'])

        # result = self.client.images.generate(
        #     model="gpt-image-1-mini",
        #     prompt=prompt,
        #     quality='high',
        # )

        # return result.data[0].b64_json

    def _generate_speaking_part1_question(
        self, topic: str = None, prompt_id: int = None, reply: str = None
    ) -> dict:
        # TODO: adjust prompt for Part 1
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
        """

        class Message(BaseModel):
            question: str

        initial = prompt_id is None

        prompt = {}

        if initial:
            prompt_input = """
Start mock test of IELTS Speaking Part 1.
You are the examinar.
Topics: {}.
            """.format(topic)

            response = self.client.responses.parse(
                model="gpt-5-nano",
                # reasoning={"effort": "medium"},
                reasoning={"effort": "low"},
                # reasoning={"effort": "minimal"},
                instructions=instructions,
                text_format=Message,
                input=prompt_input,
            )
        else:
            response = self.client.responses.parse(
                model="gpt-5-nano",
                # reasoning={"effort": "medium"},
                reasoning={"effort": "low"},
                # reasoning={"effort": "minimal"},
                instructions=instructions,
                text_format=Message,
                input=reply,
                previous_response_id=prompt_id,
            )

        msg = response.output_parsed

        # debug
        print(
            """
        previous_response_id: {}
        question: {}
            """.format(prompt_id, msg.question)
        )

        prompt["prompt_id"] = response.id
        prompt["question"] = msg.question

        return prompt

    def generate_speaking_part2_prompt(self, topic: str = None) -> dict:

        # Generates topics if it is not specified.
        if not topic:
            topic = self._generate_topics(1)[0]

        instructions = """
You are an examiner for IELTS Speaking Part 2.
You must output a Speaking Part 2 Cue Card based on the topic provided in the input.
Topic is provided as 'Topic: <topic>.' 

Non negotiable constraints:
- You must output details of the Speaking Part 2 Cue Card into the five fields: main_task, q1, q2, q3, q4.
- Ensure all fields (main_task, q1, q2, q3, and q4) must maintain tense consistency with the provided topic.
- Use formal expression consistent with official IELTS Speaking test materials.
- You must generate outputs followed by the Field Definitions.

Field Definitions:
- main_task: The sentence indicates that the examinee should explain their experiences about the given topic. The sentence must be easy to answer, without being too specific. You must make the sentence specific enough to include room for q1, q2, q3, and q4 to explain the main_task in detail, but do not include interrogatives words. The sentence must starts with "Describe ...", and include the topic given in the input. The number of words must be less than 20. (e.g., Describe a taffic rule that was introduced in your country and that your thought was a very good idea.)
- q1: The concise interrogative sentence to identify the main subject in main_task. The sentence must start with 'What' or 'Who'. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g.,  what the work of art is)
- q2: The concise interrogative sentence to ask background the main subject in main_task. The sentence must start with 'When' or 'Where'. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g., when you first saw it)
- q3: The concise interrogative sentence to ask the details of the main subject in main_task. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g., what you know about it)
- q4: The concise interrogative sentence to ask the reason why the examinee feel. The sentence must start with 'Why'. The number of words must be less than 10. The sentence must be easy to answer, without being too specific. (e.g., why you like it.)
"""

        class Response(BaseModel):
            main_task: str
            q1: str
            q2: str
            q3: str
            q4: str

        prompt_input = """
Generate details of the Speaking Part 2 Cue Card into the five fields: main_task, q1, q2, q3, q4.
Topic: {}.
        """.format(topic)

        response = self.client.responses.parse(
            model="gpt-5-nano",
            # reasoning={"effort": "medium"},
            reasoning={"effort": "low"},
            # reasoning={"effort": "minimal"},
            instructions=instructions,
            input=prompt_input,
            text_format=Response,
        )

        res = response.output_parsed

        # debug
        print(
            """
            main_task: {}
            q1: {}
            q2: {}
            q3: {}
            q4: {}
            """.format(res.main_task, res.q1, res.q2, res.q3, res.q4)
        )

        return {
            "topic": topic,
            "main_task": res.main_task,
            "q1": res.q1,
            "q2": res.q2,
            "q3": res.q3,
            "q4": res.q4,
        }

    def _generate_speaking_part3_question(
        self, topic: str = None, prompt_id: int = None, reply: str = None
    ) -> dict:
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
        """

        class Message(BaseModel):
            question: str

        initial = prompt_id is None

        prompt = {}

        if initial:
            prompt_input = """
Start mock test of IELTS Speaking Part 3.
You are the examinar.
Topic: {}.
            """.format(topic)

            response = self.client.responses.parse(
                model="gpt-5-nano",
                # reasoning={"effort": "medium"},
                reasoning={"effort": "low"},
                # reasoning={"effort": "minimal"},
                instructions=instructions,
                text_format=Message,
                input=prompt_input,
            )
        else:
            response = self.client.responses.parse(
                model="gpt-5-nano",
                # reasoning={"effort": "medium"},
                reasoning={"effort": "low"},
                # reasoning={"effort": "minimal"},
                instructions=instructions,
                text_format=Message,
                input=reply,
                previous_response_id=prompt_id,
            )

        msg = response.output_parsed

        # debug
        print(
            """
        previous_response_id: {}
        question: {}
            """.format(prompt_id, msg.question)
        )

        prompt["prompt_id"] = response.id
        prompt["question"] = msg.question

        return prompt
