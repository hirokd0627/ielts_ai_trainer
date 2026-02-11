from random import choice, randint
import time

from flask import Flask, request, jsonify, json
from decorators import auth_required
from dotenv import load_dotenv
from exceptions import AppException
from chatgpt_service import ChatGptService

# Loads environment variables from .env file.
load_dotenv()

# Ref. https://flask.palletsprojects.com/en/stable/api/#flask.Request

app = Flask(__name__)


@app.route("/hello", methods=["GET"])
@auth_required
def hello():
    if request.args.get("duration") is not None:
        duration = int(request.args.get("duration"))
        time.sleep(duration)
        return "Hello duration={}".format(duration)

    return "Hello"


@app.route("/generate-topics", methods=["POST"])
@auth_required
def generate_topics():
    """API for generating topics for Writing and Speaking."""

    json = request.get_json()

    _validate_parameters(json, ["count"])

    chatgpt = ChatGptService()

    try:
        topics = chatgpt.generate_topics(json["count"])
        resp_json = {
            "topics": topics,
        }

    except Exception:
        raise AppException("failed to generate topics: {}".format(json))

    return jsonify(resp_json)


@app.route("/writing/task1/generate-prompt", methods=["POST"])
@auth_required
def writing_task1_generate_prompt():
    """API for generating prompt for Writing Task 1."""

    json = request.get_json()

    topics = json.get("topics", None)

    chatgpt = ChatGptService()

    try:
        prompt = chatgpt.generate_writing_task1_prompt(topics)
        resp_json = {
            "topics": prompt["topics"],
            "introduction": prompt["introduction"],
            "diagram_description": prompt["description"],
            # Task 1 instruction is fixed.
            "instruction": "Summarise the information by selecting and reporting the main features, and make comparisons where relevant.",
            "img_b64": prompt["img_b64"],
        }

    except Exception:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


@app.route("/writing/task2/generate-prompt", methods=["POST"])
@auth_required
def writing_task2_generate_prompt():
    """API for generating prompt for Writing Task 2."""

    json = request.get_json()

    topics = json.get("topics", None)

    chatgpt = ChatGptService()

    try:
        prompt = chatgpt.generate_writing_task2_prompt(topics)
        resp_json = {
            "topics": prompt["topics"],
            "statement": prompt["statement"],
            "instruction": prompt["instruction"],
        }
    except Exception:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


@app.route("/speaking/part1/generate-question", methods=["POST"])
@auth_required
def speaking_part1_generate_question():
    """API for generating questions for Speaking Part 1."""
    return _speaking_generate_question(1, request.get_json())


@app.route("/speaking/part2/generate-prompt", methods=["POST"])
@auth_required
def speaking_part2_generate_prompt():
    """API for generating prompt for Speaking Part 2."""

    json = request.get_json()

    try:
        chatgpt = ChatGptService()

        resp_json = chatgpt.generate_speaking_part2_prompt(
            topic=json.get("topic", None)
        )
    except Exception:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


@app.route("/speaking/part3/generate-question", methods=["POST"])
@auth_required
def speaking_part3_generate_question():
    """API for generating questions for Speaking Part 3."""
    return _speaking_generate_question(3, request.get_json())


@app.route("/speaking/generate-transition-message", methods=["POST"])
@auth_required
def speaking_transition_message():
    """API for getting transition message for Speaking Part 3."""

    json = request.get_json()

    _validate_parameters(json, ["topic"])

    # It’s simple enough to do without an AI.
    options = [
        s.format(json["topic"])
        for s in [
            "That's interesting. Now, let's talk about {}.",
            "I see. Now, I'd like to ask you some questions about {}.",
            "Right. Let's move on to the subject of {}.",
            "Thank you. Now, turning to the topic of {}...",
            "All right. Let's change the subject and talk about {}.",
            "That's a good point. Now, let's consider {}.",
            "I understand. Now, regarding {}...",
            "Very well. Let's look at {} instead.",
            "Okay. Now, I'd like to move on to {}.",
            "Interesting. Now, let's discuss {} more generally.",
        ]
    ]
    message = choice(options)

    return jsonify({"message": message})


@app.route("/speaking/generate-closing-message", methods=["POST"])
@auth_required
def speaking_closing_message():
    """API for getting closing message for Speaking Part 3."""

    json = request.get_json()

    _validate_parameters(json, ["part"])

    # It’s simple enough to do without an AI.
    options = [
        s.format(json["part"])
        for s in [
            "Thank you. That is the end of Part {}.",
            "All right. That concludes Part {}.",
            "Thank you. We'll finish Part {} there.",
            "Okay, that's all for Part {}.",
            "Thank you. Now, let's leave Part {} there.",
            "Very well. That's the end of Part {}.",
            "Thanks. That's everything for Part {}.",
            "Thank you. That's all the questions I have for Part {}.",
            "Thank you. That completes everything for Part {}.",
            "Thank you. We have finished Part {}.",
        ]
    ]
    message = choice(options)

    return jsonify({"message": message})


@app.errorhandler(Exception)
def handle_exception(e):
    """Exception handler to return error information in JSON format."""
    response = e.get_response()
    response.data = json.dumps(
        {
            "code": e.code,
            "name": e.name,
            "description": e.description,
        }
    )
    response.content_type = "application/json"
    return response


def _validate_parameters(json: dict, names: list[str]):
    for name in names:
        if name not in json:
            raise AppException("Missing parameter: {}".format(name))


def _speaking_generate_question(part_no: int, json: any):
    """API for generating questions."""

    initial_generation = "prompt_id" not in json

    if initial_generation:
        _validate_parameters(json, ["topic"])
    else:
        _validate_parameters(json, ["prompt_id", "reply"])

    try:
        chatgpt = ChatGptService()

        if initial_generation:
            resp_json = chatgpt.generate_speaking_initial_question(
                part_no=part_no, topic=json["topic"]
            )
            # resp_json = (
            # chatgpt.generate_speaking_initial_question(
            # part_no=part_no, topic=json["topic"]
            # )
            # chatgpt.generate_speaking_part1_initial_question(topic=json["topic"])
            # if part_no == 1
            # else chatgpt.generate_speaking_part3_initial_question(
            #     topic=json["topic"]
            # )
        else:
            resp_json = chatgpt.generate_speaking_subsequent_question(
                part_no=part_no, prompt_id=json["prompt_id"], user_reply=json["reply"]
            )
            # resp_json = (
            # chatgpt.generate_speaking_art1_subsequent_question(
            #     prompt_id=json["prompt_id"], user_reply=json["reply"]
            # )
            # if part_no == 1
            # else chatgpt.generate_speaking_part3_subsequent_question(
            #     prompt_id=json["prompt_id"], user_reply=json["reply"]
            # )
            # )
    except Exception as e:
        print(e)
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)
