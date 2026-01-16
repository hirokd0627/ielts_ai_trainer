import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 2 Question Generator Screen.
class WritingTask2QuestionGeneratorScreen extends StatefulWidget {
  const WritingTask2QuestionGeneratorScreen({super.key});

  @override
  State<WritingTask2QuestionGeneratorScreen> createState() =>
      _WritingTask2QuestionGeneratorScreenState();
}

/// State for WritingTask2QuestionGeneratorScreen
class _WritingTask2QuestionGeneratorScreenState
    extends State<WritingTask2QuestionGeneratorScreen> {
  /// API service to generate prompt text
  final WritingApiService _apiSrv = WritingApiService();

  /// Generates the prompt text and returns it.
  ///
  /// Called when generation button is tapped.
  Future<String> _generatePromptText(List<String> topics) async {
    final resp = await _apiSrv.generatePromptText(topics);
    // TODO: error handling
    return resp.promptText;
  }

  /// Called when start button is tapped.
  void _onTappedStart(String promptTest, List<String> topics) {
    // TODO: navigate to answer input screen
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: WritingQuestionGeneratorScreen(
        generatePromptText: _generatePromptText,
        onTappedStart: _onTappedStart,
        testTask: TestTask.writingTask2,
      ),
    );
  }
}
