import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';

/// Builds an outlined button.
OutlinedButton buildOutlinedButton(String label, {VoidCallback? onPressed}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return BorderSide(color: AppColors.focusColor, width: 1);
        }
        return BorderSide(color: AppColors.checkboxBorderColor, width: 1);
      }),
    ),
    child: Text(label),
  );
}
