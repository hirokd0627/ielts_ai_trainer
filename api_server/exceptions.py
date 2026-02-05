from werkzeug.exceptions import HTTPException


class AppException(HTTPException):
    """Common exception for this server application."""

    def __init__(self, description: str, status_code: int | None = 500) -> None:
        super().__init__()
        self.code = status_code
        self.description = description
