from pathlib import Path
import sys

sys.path.append(str(Path(__file__).resolve().parent.parent))

from openai import OpenAI
from pydantic import BaseModel
from dotenv import load_dotenv


load_dotenv()

client = OpenAI()


class Response(BaseModel):
    question: str


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
"""

topic = "oil"

prompt_input = """
Start mock test of IELTS Speaking Part 1.
You are the examinar.
Topic: {}.
""".format(topic)

print("instruction: {}\n".format(instructions))
print("prompt_input: {}\n".format(prompt_input))

response = client.responses.parse(
    model="gpt-5-nano",
    reasoning={"effort": "medium"},
    # If minimal, it's hard to have a good conversation.
    # reasoning={"effort": "minimal"},
    instructions=instructions,
    input=prompt_input,
    text_format=Response,
)

for i in range(10):
    # reply
    prompt_input = input("Reply?: ")

    print("prompt_input: {}\n".format(prompt_input))

    response_id = response.id

    print("previous_response_id={}".format(response_id))

    response = client.responses.parse(
        model="gpt-5-nano",
        reasoning={"effort": "medium"},
        instructions=instructions,
        input=prompt_input,
        text_format=Response,
        previous_response_id=response_id,
    )
