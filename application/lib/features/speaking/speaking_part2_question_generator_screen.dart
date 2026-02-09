import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Speaking Part 2 Question Generator Screen.
class SpeakingPart2QuestionGeneratorScreen extends StatefulWidget {
  /// The prompt text to display initially.
  final String? promptText;

  /// The topics to display initially.
  final List<String>? topics;

  const SpeakingPart2QuestionGeneratorScreen({
    super.key,
    this.promptText,
    this.topics,
  });

  @override
  State<SpeakingPart2QuestionGeneratorScreen> createState() =>
      _SpeakingPart2QuestionGeneratorScreenState();
}

/// State for SpeakingPart2QuestionGeneratorScreen
class _SpeakingPart2QuestionGeneratorScreenState
    extends State<SpeakingPart2QuestionGeneratorScreen> {
  /// Called when the Start button is pressed.
  void _onTappedStart(
    String promptText,
    List<String> topics,
    String interactionId,
  ) {
    context.go(
      speakingPart2AnswerInputScreenRoutePath,
      extra: RouterExtra({'promptText': promptText, 'topics': topics}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: SpeakingQuestionGeneratorScreen(
        // generatePromptText: _generatePromptText,
        onTappedStart: _onTappedStart,
        testTask: TestTask.speakingPart2,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
