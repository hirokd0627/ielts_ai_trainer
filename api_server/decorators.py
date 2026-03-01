# ref. https://flask.palletsprojects.com/en/stable/patterns/viewdecorators/
from functools import wraps

from flask import request, abort

from settings import settings


def auth_required(f):
    """A decorator to vefiry API_KEY."""

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if (
            request.headers.get("X-API-KEY") is None
            or not request.headers.get("X-API-KEY") == settings.x_api_key
        ):
            abort(401)

        return f(*args, **kwargs)

    return decorated_function
