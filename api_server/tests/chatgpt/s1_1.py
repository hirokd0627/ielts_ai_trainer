from pathlib import Path
import sys

sys.path.append(str(Path(__file__).resolve().parent.parent))
from utils import dump_response

from openai import OpenAI
from pydantic import BaseModel
from dotenv import load_dotenv


load_dotenv()

client = OpenAI()


class Response(BaseModel):
    question: str
    transition: str
    end_mark: bool
    topic: str


instructions = """
You are an examiner for IELTS Speaking Part 1.
You must ask exactly three questions per topic.
You must ask one simple question per turn.
Your all questions must be in line with the exmanee's replys and be a natural conversation.
After the all questions, put the question field to "Thank you, that's the end of Part 1."

Rules of flow :
- You must output for each given topic in the order provided.
- For each topic, you must ask exactly three consecutive questions.
- A single turn consists of one simple question.
- Do not end the session until you have asked the number of topics * 3 questions in total.

Definition of Topic:
- Topic is the high-level categories, they are given in the input in the format, "Topics: <Topics are listed separated commma>".
- The number of given topics is from one to three.

Constraints for 'question' field:
- You must ask only one thing. 
- Do not make combined questions.
- Never use 'and' or 'or' to combine two things at once.
- Do not include a topic transition in this field. Put only a question. 

Constraints for 'transition' field:
- When moving to a new topic in the given topics, You must put a sentence for transition in this field like 'Next, I'd like to talk about <insert the given topic here>'.
- Otherwise, put an empty "" in this field.
Do not any output if the conversation is moving between differenct details of the same topic.

Constrains for 'end_mark' field:
- Put 'true' when put the question field to "Thank you, that's the end of Part 1." after the all questions.
- Othwerwise, put 'false'.

Constrains for 'end_mark' field:
- Put topic word of the question. 
- When the last question after the all questions, put empty "".
"""

input_topics = ",".join(["food", "home"])

prompt_input = """
Start mock test of IELTS Speaking Part 1.
You are the examinar.
Topics: {}.
""".format(input_topics)

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

dump_response(response)

for i in range(7):
    # reply
    prompt_input = input("Reply?: ")

    print("prompt_input: {}\n".format(prompt_input))

    response = client.responses.parse(
        model="gpt-5-nano",
        reasoning={"effort": "medium"},
        instructions=instructions,
        input=prompt_input,
        text_format=Response,
        previous_response_id=response.id,
    )

    dump_response(response)
