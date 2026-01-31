import time
from flask import Flask, request, jsonify

# Ref. https://flask.palletsprojects.com/en/stable/api/#flask.Request

app = Flask(__name__)

@app.route('/hello', methods=['GET'])
def hello():
    if request.args.get('duration') is not None:
        duration = int(request.args.get('duration'))
        time.sleep(duration)
        return 'Hello duration={}'.format(duration)

    return 'Hello'

# TODO: implement API
# @app.route('/dummy', methods=['POST'])
# def generate_prompt():
#     json = request.get_json()

#     resp_json= {}
#     return jsonify(resp_json)
