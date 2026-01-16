import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/views/header_menu.dart';

/// Base scaffold for screens with HeaderMenuBar
class BaseScreenScaffold extends StatelessWidget {
  /// The main widget of the screen.
  final Widget body;

  /// Whether to show the header.
  final bool showHeader;

  const BaseScreenScaffold({
    super.key,
    required this.body,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (showHeader) HeaderMenuBar(),
          Expanded(child: body),
        ],
      ),
    );
  }
}
