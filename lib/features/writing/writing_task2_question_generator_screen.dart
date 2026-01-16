import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task2_essay_type.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 2 Question Generator Screen.
class WritingTask2QuestionGeneratorScreen extends StatefulWidget {
  /// The essay type to display initially, if set.
  final WritingTask2EssayType? essayType;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingTask2QuestionGeneratorScreen({
    super.key,
    this.essayType,
    this.promptText,
    this.topics,
  });

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
  Future<String> _generatePromptText(
    dynamic promptType,
    List<String> topics,
  ) async {
    final essayType = promptType as WritingTask2EssayType;
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
      writingTask2AnswerInputScreenRoutePath,
      extra: RouterExtra({
        'promptText': promptText,
        'topics': topics,
        'essayType': promptType as WritingTask2EssayType,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: WritingQuestionGeneratorScreen(
        generatePromptText: _generatePromptText,
        onTappedStart: _onTappedStart,
        testTask: TestTask.writingTask2,
        essayType: widget.essayType,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
