# IELTS AI Trainer

This application is available on Windows and macOS and allows users to practice IELTS Writing and Speaking.

## Tested Platforms

This application has been tested on the following platforms. Other platforms may also work but are not tested.

- macOS 15.7.3 or later
- Windows 11

## Development

### Development Environment Setup

1. Install the Flutter SDK by following the official installation guide: https://docs.flutter.dev/install
2. Run `flutter pub get`
3. Run the code generation for Drift and Freezed.

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Running the App in Development

Run `flutter run`

### Build the App for Distribution

- Windows: Run `flutter build windows`
- macOS: Run `flutter build macos`

----

Copyright (c) 2026 Takahiro Kudo

License: Apache-2.0