import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';

/// Styles of the application.
class AppStyles {
  /// TextField text style.
  /// Text filed height = 48
  static TextStyle? textFieldStyle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.textColor);
  }

  /// Placeholder text style.
  static TextStyle get placeHolderText {
    return TextStyle(
      color: AppColors.placeholderTextColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
  }

  /// Screen horizontal padding.
  static double get screenPadding => 24;

  /// Screen bottom padding.
  static double get screenBottomPadding => 24;
}
