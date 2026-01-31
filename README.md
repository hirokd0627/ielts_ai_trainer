# IELTS AI Trainer

This application is available on Windows and macOS and allows users to practice IELTS Writing and Speaking.

## Tested Platforms

This application has been tested on the following platforms. Other platforms may also work but are not tested.

- macOS 15.7.3 or later
- Windows 11
- Python 3.13.7

## Development

This application consists of two components.
 - A Flutter desktop application that provides the user interface.
 - A Flask backend API that generates prompt text and evaluates the user's answers using AI agents.

### Application

#### Development Environment Setup

1. Install the Flutter SDK by following the official installation guide: https://docs.flutter.dev/install
2. Run

```sh
cd application
flutter pub get
```

3. Run the code generation for Drift and Freezed.

```bash
dart run build_runner build --delete-conflicting-outputs
```

#### Running the App in Development

Run `flutter run`

Note: The app expects the backend API on `http://127.0.0.1:5000` during development.

#### Build the App for Distribution

- Windows: Run `flutter build windows`
- macOS: Run `flutter build macos`

### Backend API

#### Development Environment Setup

1. Create the Python virtual environment.

```sh
cd api_server
python -m venv ./venv
source venv/bin/activate
```

2. Install packages.

```sh
pip install -r ./requirements.txt
```

#### Running the Server in Development

Run `flask --app main run` and open `http://127.0.0.1:5000`.

```sh
flask --app main run         
>  * Serving Flask app 'main'
>  * Debug mode: off
> WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
>  * Running on http://127.0.0.1:5000
> Press CTRL+C to quit
```

----

Copyright (c) 2026 Takahiro Kudo

License: Apache-2.0