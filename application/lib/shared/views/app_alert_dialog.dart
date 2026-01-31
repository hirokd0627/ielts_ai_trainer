import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';

/// Alert dialog.
class AppAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  const AppAlertDialog({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.chipBackground),
          ),
          child: Text('Close'),
        ),
      ],
    );
  }
}
