import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 1 Question Generator Screen.
class WritingTask1QuestionGeneratorScreen extends StatefulWidget {
  /// The question type to display initially, if set.
  final WritingTask1QuestionType? questionType;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingTask1QuestionGeneratorScreen({
    super.key,
    this.questionType,
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

  /// Generates the prompt text and returns it.
  ///
  /// Called when generation button is tapped.
  Future<String> _generatePromptText(
    dynamic promptType,
    List<String> topics,
  ) async {
    final questionType = promptType as WritingTask1QuestionType;
    final resp = await _apiSrv.generatePromptText(topics);
    // TODO: error handling
    return resp.promptText;
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
        'questionType': promptType as WritingTask1QuestionType,
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
        questionType: widget.questionType,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
