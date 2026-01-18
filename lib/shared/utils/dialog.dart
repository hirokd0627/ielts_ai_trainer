import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/views/app_alert_dialog.dart';
import 'package:ielts_ai_trainer/shared/views/confirm_dialog.dart';

/// Shows a confirmation dialog.
/// Returns true if the yes button is pressed.
Future<bool?> showConfirmDialog(
  BuildContext context,
  String title,
  String message, {
  String? yesLabel,
  String? noLabel,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => ConfirmDialog(
      title: title,
      message: message,
      yesLabel: yesLabel,
      noLabel: noLabel,
    ),
    barrierDismissible: false, // must tap button
  );
}

/// Shows an alert dialog.
Future<bool?> showAlertDialog(
  BuildContext context,
  String title,
  String message,
) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AppAlertDialog(title: title, message: message),
    barrierDismissible: false, // must tap button
  );
}
