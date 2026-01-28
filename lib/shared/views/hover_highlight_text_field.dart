import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';

/// A TextField that highlights its border when hovered.
class HoverHighlightTextField extends StatefulWidget {
  final bool? enabled;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const HoverHighlightTextField({
    super.key,
    this.enabled,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.controller,
  });

  @override
  State<HoverHighlightTextField> createState() =>
      _HoverHighlightTextFieldState();
}

/// State for HoverHighlightTextField.
class _HoverHighlightTextFieldState extends State<HoverHighlightTextField> {
  /// Whether the mouse cursor is on the TextField.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        // Handle hover enter
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: TextField(
        controller: widget.controller,
        enabled: widget.enabled,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.focusColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isHovered ? AppColors.focusColor : AppColors.borderColor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor, width: 1),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.placeholderTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
