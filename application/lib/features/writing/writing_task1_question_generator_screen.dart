import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 1 Question Generator Screen.
class WritingTask1QuestionGeneratorScreen extends StatefulWidget {
  /// The question type to display initially, if set.
  final WritingPromptType? promptType;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingTask1QuestionGeneratorScreen({
    super.key,
    this.promptType,
    this.promptText,
    this.topics,
  });

  @override
  State<WritingTask1QuestionGeneratorScreen> createState() =>
      _WritingTask1QuestionGeneratorScreenState();
}

/// State for WritingTask1QuestionGeneratorScreen
class _WritingTask1QuestionGeneratorScreenState
    extends State<WritingTask1QuestionGeneratorScreen> {
  /// API service to generate prompt text
  final WritingApiService _apiSrv = WritingApiService();

  /// Called when the Generate button is tapped.
  /// Generates prompt text using the given topics.
  /// Returns a record containing the generated prompt text and the topics used.
  Future<({List<String> topics, String promptText})> _generatePromptText(
    WritingPromptType promptType,
    List<String> topics,
  ) async {
    final resp = await _apiSrv.generatePromptText(topics);
    // TODO: error handling
    return (topics: resp.topics, promptText: resp.promptText);
  }

  /// Called when start button is tapped.
  void _onTappedStart(
    String promptText,
    List<String> topics,
    dynamic promptType,
  ) {
    context.go(
      writingTask1AnswerInputScreenRoutePath,
      extra: RouterExtra({
        'promptText': promptText,
        'topics': topics,
        'promptType': promptType,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: WritingQuestionGeneratorScreen(
        generatePromptText: _generatePromptText,
        onTappedStart: _onTappedStart,
        testTask: TestTask.writingTask1,
        promptType: widget.promptType,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
