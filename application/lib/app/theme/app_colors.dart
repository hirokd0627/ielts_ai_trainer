import 'package:flutter/painting.dart';

/// Defines the colors used in the app.
abstract class AppColors {
  /// Primary text color for main text.
  static const textColor = Color(0xFF0D0D0D);

  /// Secondary text color for less prominent text.
  static const secondaryTextColor = Color(0xFF606060);

  /// Color for disabled text.
  static const disabledTextColor = Color(0xFF909090);

  /// Color for placeholder text in a text field.
  static const placeholderTextColor = Color(0xFFA0A0A0);

  /// Background color for Chip widgets.
  static const chipBackground = Color(0x10000000);

  /// Default color for borders.
  static const borderColor = Color(0xFFCCCCCC);

  /// Border color for checkboxes.
  static const checkboxBorderColor = Color(0xFF909090);

  /// Focus color to indicate focus.
  static const focusColor = Color(0xFF0D0D0D);

  /// Error color to indicate errors.
  static const errorRed = Color(0xFF990412);

  /// Color for drop shadows
  static const dropShadow = Color(0x60000000);
}
