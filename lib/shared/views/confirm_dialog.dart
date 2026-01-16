import 'package:flutter/material.dart';

/// Confirmation dialog with Yes/No buttons.
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String yesLabel;
  final String noLabel;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    String? yesLabel,
    String? noLabel,
  }) : yesLabel = yesLabel ?? 'OK',
       noLabel = noLabel ?? 'Cancel';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        // Cancel
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(noLabel),
        ),
        // OK
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(yesLabel),
        ),
      ],
    );
  }
}
