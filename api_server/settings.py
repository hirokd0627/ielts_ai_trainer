from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Settings provides server setting values, such as environment variables."""

    x_api_key: str = ""
    openai_api_key: str = ""
    gemini_api_key: str = ""
    env: str = ""
    az_speech_api_key: str = ""
    az_region: str = ""
    debug: bool = False

    model_config = SettingsConfigDict(
        env_prefix="MY_APP_", env_file=".env", env_file_encoding="utf-8"
    )


"""Usage:
from settings import settings

if settings.debug == '':
    ...
"""
settings = Settings()
