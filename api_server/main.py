from random import choice
import math
import time
import tempfile
import os
import shutil

from flask import Flask, request, jsonify
from decorators import auth_required
from dotenv import load_dotenv
from exceptions import AppException
from chatgpt_service import ChatGptService
from streaming_form_data import StreamingFormDataParser
from streaming_form_data.targets import FileTarget, ValueTarget

# Load environment variables from .env file.
load_dotenv()

# Ref. https://flask.palletsprojects.com/en/stable/api/#flask.Request

app = Flask(__name__)


@app.route("/hello", methods=["GET"])
@auth_required
def hello():
    """API for health check."""

    if request.args.get("duration") is not None:
        duration = int(request.args.get("duration"))
        time.sleep(duration)
        return "Hello duration={}".format(duration)

    return "Hello"


@app.route("/generate-topics", methods=["POST"])
@auth_required
def generate_topics():
    """API for generating topics for Writing and Speaking.

    Args: application/json
        count: See `ChatGptService.generate_topics`.

    Returns: application/json
        topics: See `ChatGptService.generate_topics`.
    """

    json = request.get_json()
    _validate_parameters(json, "count")

    try:
        chatgpt = ChatGptService()
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
    """API for generating prompt for Writing Task 1.

    Args: application/json
        diagram_type, topics:
            See `ChatGptService.generate_writing_task1_prompt`.

    Returns: application/json
        topics, introduction, diagram_description, diagram_data:
            See `ChatGptService.generate_writing_task1_prompt`.
        instruction (str): Instruction sentence put after intruduction sentence.
    """

    json = request.get_json()
    _validate_parameters(json, ["topics", "diagram_type"])

    try:
        chatgpt = ChatGptService()
        prompt = chatgpt.generate_writing_task1_prompt(
            json["diagram_type"], json["topics"]
        )
        resp_json = {
            "topics": prompt["topics"],
            "introduction": prompt["introduction"],
            "diagram_description": prompt["diagram_description"],
            "diagram_data": prompt["diagram_data"],
            # Task 1 instruction is fixed.
            "instruction": "Summarise the information by selecting and "
            "reporting the main features, and make comparisons where "
            "relevant.",
        }

    except Exception as e:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


@app.route("/writing/task2/generate-prompt", methods=["POST"])
@auth_required
def writing_task2_generate_prompt():
    """API for generating prompt for Writing Task 2.

    Args: application/json
        essay_type, topics: See `ChatGptService.generate_writing_task2_prompt`.

    Returns: application/json
        See `ChatGptService.generate_writing_task2_prompt`.
    """

    json = request.get_json()
    _validate_parameters(json, ["topics", "essay_type"])

    try:
        chatgpt = ChatGptService()
        prompt = chatgpt.generate_writing_task2_prompt(
            json["essay_type"], json["topics"]
        )
        resp_json = {
            "topics": prompt["topics"],
            "statement": prompt["statement"],
            "instruction": prompt["instruction"],
        }
    except Exception as e:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


@app.route("/speaking/part1/generate-question", methods=["POST"])
@auth_required
def speaking_part1_generate_question():
    """API for generating question for Speaking Part 1.

    Args: application/json
        See `_speaking_generate_question`.

    Returns: application/json
        See `_speaking_generate_question`.
    """
    return _speaking_generate_question(1, request.get_json())


@app.route("/speaking/part2/generate-cuecard", methods=["POST"])
@auth_required
def speaking_part2_generate_cuecard():
    """API for generating cur card content for Speaking Part 2.

    Args: application/json
        topic: See `ChatGptService.generate_speaking_part2_cuecard`.

    Returns: application/json
        See `ChatGptService.generate_speaking_part2_cuecard`.
    """

    json = request.get_json()
    _validate_parameters(json, "topic")

    try:
        chatgpt = ChatGptService()
        resp_json = chatgpt.generate_speaking_part2_cuecard(
            topic=json["topic"]
        )
    except Exception:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


@app.route("/speaking/part3/generate-question", methods=["POST"])
@auth_required
def speaking_part3_generate_question():
    """API for generating question for Speaking Part 3.

    Args: application/json
        See `_speaking_generate_question`.

    Returns: application/json
        See `_speaking_generate_question`.
    """

    return _speaking_generate_question(3, request.get_json())


@app.route("/speaking/generate-transition-message", methods=["POST"])
@auth_required
def speaking_transition_message():
    """API for getting transition message for Speaking Part 1 and Part 3.

    Args: application/json
        topic (str): Topic to include message.

    Returns: application/json
        message (str): Generated transition message.
    """

    json = request.get_json()
    _validate_parameters(json, "topic")

    # Randomly select from pre-generated sentences.
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
    """API for getting closing message for Speaking Part 1 and Part 3.

    Args: application/json
        topic (str): Topic to include message.

    Returns: application/json
        message (str): Generated transition message.
    """

    json = request.get_json()
    _validate_parameters(json, "part")

    # Randomly select from pre-generated sentences.
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


@app.route("/writing/task1/evaluate", methods=["POST"])
@auth_required
def writing_task1_evaluate():
    """API for evaluating the answer for Writing Task 1.

    Args: application/json
        prompt, diagram_type, diagram_description, answer:
            See `ChatGptService.evaluate_writing_task1_answer`.

    Returns: application/json
        achievement_score, coherence_score, grammatical_score, lexical_score:
            See `ChatGptService.evaluate_writing_task1_answer`.
        achievement_feedback (str):
            Feedback for Task Achievement, including positive and negative ones.
        coherence_feedback (str):
            Feedback for Coherence and Cohesion, including positive and negative ones.
        grammatical_feedback (str):
            Feedback for Grammatical Range and Accuracy, including positive and negative ones.
        lexical_feedback (str):
            Feedback for Lexical Resource, including positive and negative ones.
    """

    json = request.get_json()
    _validate_parameters(
        json, ["prompt", "diagram_type", "diagram_description", "answer"]
    )

    try:
        chatgpt = ChatGptService()
        evaluation = chatgpt.evaluate_writing_task1_answer(
            prompt=json["prompt"],
            diagram_type=json["diagram_type"],
            diagram_description=json["diagram_description"],
            answer=json["answer"],
        )
    except Exception:
        raise AppException("failed to evaluate answer: {}".format(json))

    resp_json = {
        "achievement_score": evaluation.achievement_score,
        "coherence_score": evaluation.coherence_score,
        "grammatical_score": evaluation.grammatical_score,
        "lexical_score": evaluation.lexical_score,
        # TODO:
        "band_score": _calculate_band_score(
            evaluation.achievement_score,
            evaluation.coherence_score,
            evaluation.grammatical_score,
            evaluation.lexical_score,
        ),
        "achievement_feedback": [
            evaluation.achievement_feedback1,
            evaluation.achievement_feedback2,
        ],
        "coherence_feedback": [
            evaluation.coherence_feedback1,
            evaluation.coherence_feedback2,
        ],
        "grammatical_feedback": [
            evaluation.grammatical_feedback1,
            evaluation.grammatical_feedback2,
        ],
        "lexical_feedback": [
            evaluation.lexical_feedback1,
            evaluation.lexical_feedback2,
        ],
    }

    return jsonify(resp_json)


@app.route("/writing/task2/evaluate", methods=["POST"])
@auth_required
def writing_task2_evaluate():
    """API for evaluating the answer for Writing Task 2.

    Args: application/json
        prompt, answer:
            See `ChatGptService.evaluate_writing_task2_answer`.

    Returns: application/json
        response_score, coherence_score, grammatical_score, lexical_score:
            See `ChatGptService.evaluate_writing_task2_answer`.
        band_score: TODO:
        response_feedback (str):
            Feedback for Task Response, including positive and negative ones.
        coherence_feedback (str):
            Feedback for Coherence and Cohesion, including positive and negative ones.
        grammatical_feedback (str):
            Feedback for Grammatical Range and Accuracy, including positive and negative ones.
        lexical_feedback (str):
            Feedback for Lexical Resource, including positive and negative ones.
    """

    json = request.get_json()
    _validate_parameters(json, ["prompt", "answer"])

    try:
        chatgpt = ChatGptService()
        evaluation = chatgpt.evaluate_writing_task2_answer(
            prompt=json["prompt"],
            answer=json["answer"],
        )
    except Exception:
        raise AppException("failed to evaluate answer: {}".format(json))

    resp_json = {
        "response_score": evaluation.response_score,
        "coherence_score": evaluation.coherence_score,
        "grammatical_score": evaluation.grammatical_score,
        "lexical_score": evaluation.lexical_score,
        "band_score": _calculate_band_score(
            evaluation.response_score,
            evaluation.coherence_score,
            evaluation.grammatical_score,
            evaluation.lexical_score,
        ),
        "response_feedback": [
            evaluation.response_feedback1,
            evaluation.response_feedback2,
        ],
        "coherence_feedback": [
            evaluation.coherence_feedback1,
            evaluation.coherence_feedback2,
        ],
        "grammatical_feedback": [
            evaluation.grammatical_feedback1,
            evaluation.grammatical_feedback2,
        ],
        "lexical_feedback": [
            evaluation.lexical_feedback1,
            evaluation.lexical_feedback2,
        ],
    }

    return jsonify(resp_json)


@app.route("/speaking/part1/evaluate", methods=["POST"])
@auth_required
def speaking_part1_evaluate():
    """API for evaluating the answer for Speaking Part 1.

    Args: application/json
        See `_speaking_answer_evaluate`.

    Returns: application/json
        See `_speaking_answer_evaluate`.
    """
    return _speaking_answer_evaluate(1)


@app.route("/speaking/part2/evaluate", methods=["POST"])
@auth_required
def speaking_part2_evaluate():
    """API for evaluating the answer for Speaking Part 2.

    Args: application/json
        prompt, speech: See `ChatGptService.evaluate_speaking_part2_answer`.

    Returns: application/json
        coherence_score, lexical_score, grammatical_score:
            See `ChatGptService.evaluate_speaking_part2_answer`.
        coherence_feedback (str):
            Feedback for Coherence and Cohesion, including positive and negative ones.
        lexical_feedback (str):
            Feedback for Lexical Resource, including positive and negative ones.
        grammatical_feedback (str):
            Feedback for Grammatical Range and Accuracy, including positive and negative ones.
    """

    json = request.get_json()
    _validate_parameters(json, ["prompt", "speech"])

    try:
        chatgpt = ChatGptService()
        evaluation = chatgpt.evaluate_speaking_part2_answer(
            prompt=json["prompt"],
            speech=json["speech"],
        )
    except Exception:
        raise AppException("failed to evaluate answer: {}".format(json))

    return _build_speaking_answer_evaluate_reponse(evaluation=evaluation)


@app.route("/speaking/part3/evaluate", methods=["POST"])
@auth_required
def speaking_part3_evaluate():
    """API for evaluating the answer for Speaking Part 3.

    Args: application/json
        See `_speaking_answer_evaluate`.

    Returns: application/json
        See `_speaking_answer_evaluate`.
    """

    return _speaking_answer_evaluate(3)


@app.route("/speaking/evaluate-pronunciation", methods=["POST"])
@auth_required
def speaking_evaluate_pronunciation():
    """API for evaluating pronunciation with script.

    Args: multipart/form-data
        script (str): Script of speech.
        audio_data (bytes): Recorded audio data (m4a) of the user's speech.

    Returns: application/json
        score (float): Fluency score.
    """

    # Ref. https://github.com/siddhantgoel/streaming-form-data

    # Create temporary .m4a file.
    with tempfile.NamedTemporaryFile(delete=False, suffix=".m4a") as f:
        tmp_name = f.name

    print("tmp_name: {}".format(tmp_name))

    script_target = ValueTarget()
    audio_file_target = FileTarget(tmp_name)

    parser = StreamingFormDataParser(headers=request.headers)
    parser.register("script", script_target)
    parser.register("audio_data", audio_file_target)

    # Read data through stream.
    byte_len = 262144  # 256K bytes
    try:
        while True:
            chunk = request.stream.read(byte_len)
            if not chunk:
                break
            parser.data_received(chunk)

        script = script_target.value.decode("utf-8")
        audio_file_target.on_finish()

        print("script: {}".format(script))

        # TODO: Call Azure Speech Service

        # TODO: test file check
        target_dir = "/Users/hiro/oregon-work/gcs/cs406/repo_cs406_ielts_ai_trainer/api_server/_tests/audio"
        shutil.copy2(tmp_name, target_dir)

    finally:
        # Delete temporary file.
        if os.path.exists(tmp_name):
            os.remove(tmp_name)

    return jsonify(
        {
            "score": 3.5,
        }
    )


@app.errorhandler(Exception)
def handle_exception(e):
    """Exception handler to return error information in JSON format."""
    return jsonify({"error": str(e)})


def _validate_parameters(json: dict, names: str | list[str]):
    """Validate POST parameters.

    Args:
        json: POST parameters.
        names: Single key name or List of key name in json to verify.

    Raises:
        AppException: if key name in names is not in json.
    """
    names = [names] if isinstance(names, str) else names

    for name in names:
        if name not in json:
            raise AppException("Missing parameter: {}".format(name))


def _speaking_generate_question(part_no: int, json: any):
    """API for generating question for Speaking Part 1 and Part 3.

    Args:
        part_no: Speaking Part number, 1 or 3.
        json: POST parameters.

    Returns:
        Generated question components:
            - prompt_id (str): ChatGPT prompt ID to continue interaction.
            - question (str): Generated question sentence.
    """

    initial_generation = "prompt_id" not in json

    if initial_generation:
        _validate_parameters(json, "topic")
    else:
        _validate_parameters(json, ["prompt_id", "reply"])

    try:
        chatgpt = ChatGptService()

        if initial_generation:
            resp_json = chatgpt.generate_speaking_initial_question(
                part_no=part_no, topic=json["topic"]
            )
        else:
            resp_json = chatgpt.generate_speaking_subsequent_question(
                part_no=part_no,
                prompt_id=json["prompt_id"],
                user_reply=json["reply"],
            )
    except Exception as e:
        raise AppException("failed to generate prompt: {}".format(json))

    return jsonify(resp_json)


# TODO:
def _calculate_band_score(
    s1: float, s2: float, s3: float, s4: float = None
) -> float:
    """Returns IELTS band score based on four criteria scores."""
    sum = s1 + s2 + s3
    if s4 is not None:
        sum += s4
    avg = sum / 4 if s4 is not None else sum / 3
    frac, score = math.modf(avg)
    if frac >= 0.75:
        score += 1.0
    elif frac >= 0.25:
        score += 0.5

    return score


def _speaking_answer_evaluate(part_no: int):
    """Evaluate the answer for Speaking Part 1 and 3.

    Args:
        part_no: Speaking Part number.

    Returns:
        see _build_speaking_answer_evaluate_reponse.
    """
    json = request.get_json()
    _validate_parameters(json, ["script"])

    try:
        chatgpt = ChatGptService()
        if part_no == 1:
            evaluation = chatgpt.evaluate_speaking_part1_answer(
                script=json["script"],
            )
        elif part_no == 3:
            evaluation = chatgpt.evaluate_speaking_part3_answer(
                script=json["script"],
            )
    except Exception:
        raise AppException("failed to evaluate answer: {}".format(json))

    return _build_speaking_answer_evaluate_reponse(evaluation=evaluation)


def _build_speaking_answer_evaluate_reponse(evaluation: dict) -> str:
    """Build response of evaluation for Speaking Parts."""
    resp_json = {
        "coherence_score": evaluation.coherence_score,
        "lexical_score": evaluation.lexical_score,
        "grammatical_score": evaluation.grammatical_score,
        "band_score": _calculate_band_score(
            evaluation.coherence_score,
            evaluation.lexical_score,
            evaluation.grammatical_score,
        ),
        "coherence_feedback": [
            evaluation.coherence_feedback1,
            evaluation.coherence_feedback2,
        ],
        "lexical_feedback": [
            evaluation.lexical_feedback1,
            evaluation.lexical_feedback2,
        ],
        "grammatical_feedback": [
            evaluation.grammatical_feedback1,
            evaluation.grammatical_feedback2,
        ],
    }

    return jsonify(resp_json)
