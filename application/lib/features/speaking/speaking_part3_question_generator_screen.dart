import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Speaking Part 3 Question Generator Screen.
class SpeakingPart3QuestionGeneratorScreen extends StatefulWidget {
  /// The prompt text to display initially.
  final String? promptText;

  /// The topics to display initially.
  final List<String>? topics;

  const SpeakingPart3QuestionGeneratorScreen({
    super.key,
    this.promptText,
    this.topics,
  });

  @override
  State<SpeakingPart3QuestionGeneratorScreen> createState() =>
      _SpeakingPart3QuestionGeneratorScreenState();
}

/// State for SpeakingPart3QuestionGeneratorScreen
class _SpeakingPart3QuestionGeneratorScreenState
    extends State<SpeakingPart3QuestionGeneratorScreen> {
  /// Called when the Start button is pressed.
  void _onTappedStart(
    String promptText,
    List<String> topics,
    String interactionId,
  ) {
    context.go(
      speakingPart3AnswerInputScreenRoutePath,
      extra: RouterExtra({
        'initialPromptText': promptText,
        'topics': topics,
        'interactionId': interactionId,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: SpeakingQuestionGeneratorScreen(
        // generatePromptText: _generatePromptText,
        onTappedStart: _onTappedStart,
        testTask: TestTask.speakingPart3,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
