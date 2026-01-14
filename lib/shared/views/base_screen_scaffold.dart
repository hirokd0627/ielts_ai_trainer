import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/views/header_menu.dart';

/// Base scaffold for screens with HeaderMenuBar
class BaseScreenScaffold extends StatelessWidget {
  final Widget body;

  const BaseScreenScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderMenuBar(),
          Expanded(child: body),
        ],
      ),
    );
  }
}
