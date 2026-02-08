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


@app.route("/speaking/part1/generate-prompt", methods=["POST"])
@auth_required
def speaking_part1_generate_prompt():
    """API for generating prompt for Speaking Part 1."""

    json = request.get_json()

    initial_generation = "prompt_id" not in json

    if initial_generation:
        _validate_parameters(json, ["topic_count"])
    else:
        _validate_parameters(json, ["prompt_id", "reply"])

    try:
        chatgpt = ChatGptService()

        if initial_generation:
            topics = json.get("topics", None)
            resp_json = chatgpt.generate_initial_speaking_part1_prompt(
                topic_count=json["topic_count"], topics=topics
            )
        else:
            resp_json = chatgpt.generate_subsequent_speaking_part1_prompt(
                prompt_id=json["prompt_id"], user_reply=json["reply"]
            )
    except Exception:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


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
