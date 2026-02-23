import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';

/// Styles of the application.
class AppStyles {
  /// TextField text style.
  /// Text filed height = 48
  static TextStyle? textFieldStyle(
    BuildContext context, {
    bool enabled = true,
  }) {
    final color = enabled
        ? AppColors.textColor
        : AppColors.placeholderTextColor;
    return Theme.of(context).textTheme.bodyMedium?.copyWith(color: color);
  }

  /// Placeholder text style.
  static TextStyle get placeHolderText {
    return TextStyle(
      color: AppColors.placeholderTextColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
  }

  /// Helper text style.
  static TextStyle get helperTextStyle {
    return TextStyle(
      // color: Colors.grey.shade700,
      color: AppColors.secondaryTextColor,
      fontWeight: FontWeight.w400,
      fontSize: 13,
    );
  }

  /// Screen horizontal padding.
  static double get screenPadding => 24;

  /// Screen bottom padding.
  static double get screenBottomPadding => 24;
}
