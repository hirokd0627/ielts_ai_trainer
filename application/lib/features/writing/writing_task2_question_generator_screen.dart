import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 2 Question Generator Screen.
class WritingTask2QuestionGeneratorScreen extends StatefulWidget {
  /// The prompt type to display initially, if set.
  final WritingPromptType? promptType;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingTask2QuestionGeneratorScreen({
    super.key,
    this.promptType,
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
        'promptType': promptType,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: WritingQuestionGeneratorScreen(
        onTappedStart: _onTappedStart,
        testTask: TestTask.writingTask2,
        promptType: widget.promptType,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
