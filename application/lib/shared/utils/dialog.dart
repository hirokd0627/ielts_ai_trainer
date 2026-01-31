import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/views/app_alert_dialog.dart';
import 'package:ielts_ai_trainer/shared/views/confirm_dialog.dart';

/// Shows a dialog to confirm starting practice.
/// Returns true if the Start button is pressed.
Future<bool?> showStartPracticeDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) =>
        const ConfirmDialog(title: 'Ready to start?', yesLabel: 'Start'),
    barrierDismissible: false, // must press button
  );
}

/// Shows a dialog to confirm quitting practice.
/// Returns true if the Quit button is pressed.
Future<bool?> showQuitPracticeDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const ConfirmDialog(
      title: 'Quit practice?',
      message: 'Your input will be discarded.',
      yesLabel: 'Quit',
    ),
    barrierDismissible: false, // must press button
  );
}

/// Shows a dialog to confirm submitting the answers.
/// Returns true if the Submit button is pressed.
Future<bool?> showSubmitAnswerDialog(
  BuildContext context, {
  bool multipleAnswers = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => ConfirmDialog(
      title: multipleAnswers ? 'Submit your answers?' : 'Submit your answer?',
      yesLabel: 'Submit',
    ),
    barrierDismissible: false, // must press button
  );
}

/// Shows an alert dialog.
Future<bool?> showAlertDialog(
  BuildContext context,
  String title,
  String? message,
) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AppAlertDialog(title: title, message: message ?? ''),
    barrierDismissible: false, // must tap button
  );
}
