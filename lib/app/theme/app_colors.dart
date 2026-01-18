import 'package:flutter/painting.dart';

abstract class AppColors {
  static const textColor = Color(0xFF0D0D0D); // text primary

  static const secondaryTextColor = Color(0xFF606060);
  static const disabledTextColor = Color(0xFF909090); // --ytcp-txt-disabled
  static const placeholderTextColor = Color(0xFFA0A0A0);

  static const chipBackground = Color(0x10000000);

  static const borderColor = Color(0xFFCCCCCC); // --ytcp-container-border-color
  static const focusColor = Color(0xFF0D0D0D);
  // border  : ccc
  // borer focus: 0d0d0d
  // error-red: #990412;
  static const errorRed = Color(0xFF990412);

  // Colors.black.withOpacity(0.3)
  // text bold: 700
  // text normal: 500

  // static const dropShadow = Color(0x1E000000);
  static const dropShadow = Color(0x60000000);

  // --ytcp-chip-background: rgba(0, 0, 0, 0.06);
  // --ytcp-chip-background-hover: #e9e9e9;
  // --ytcp-chip-background-active: #0d0d0d;
  // --ytcp-chip-background-active-hover: #606060;
  // --ytcp-overlay-drop-shadow-app-header: rgba(0, 0, 0, 0.12);
  // --ytcp-static-overlay-drop-shadow-a12: rgba(0, 0, 0, 0.12);
  // --ytcp-static-overlay-drop-shadow-a40: rgba(0, 0, 0, 0.4);
  // --yt-spec-inverted-background: #0f0f0f;
  //     --yt-spec-additive-background: rgba(0, 0, 0, 0.05);
  //     --yt-spec-additive-background-inverse: rgba(255, 255, 255, 0.1);
  //     --yt-spec-outline: rgba(0, 0, 0, 0.1);
  //     --yt-spec-outline-inverse: rgba(255, 255, 255, 0.2);
  //     --yt-spec-text-primary: #030303;
}
