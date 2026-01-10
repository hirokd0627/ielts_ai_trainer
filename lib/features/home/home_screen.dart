import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Home screen shown on app launch, displaying questions users have previously
/// practiced.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State for HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(body: Column(children: [Text("Home Screen")]));
  }
}
