import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_routes.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Speaking Part 1 Question Generator Screen.
class SpeakingPart1QuestionGeneratorScreen extends StatefulWidget {
  /// The prompt text to display initially.
  final String? promptText;

  /// The topics to display initially.
  final List<String>? topics;

  /// ID issued when the initial prompt was generated.
  final String? initialInteractionId;

  const SpeakingPart1QuestionGeneratorScreen({
    super.key,
    this.promptText,
    this.topics,
    this.initialInteractionId,
  });

  @override
  State<SpeakingPart1QuestionGeneratorScreen> createState() =>
      _SpeakingPart1QuestionGeneratorScreenState();
}

/// State for SpeakingPart1QuestionGeneratorScreen
class _SpeakingPart1QuestionGeneratorScreenState
    extends State<SpeakingPart1QuestionGeneratorScreen> {
  /// Called when the Start button is pressed.
  void _onTappedStart(
    String promptText,
    List<String> topics,
    String interactionId,
  ) {
    context.go(
      speakingPart1AnswerInputScreenRoutePath,
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
        onTappedStart: _onTappedStart,
        testTask: TestTask.speakingPart1,
        promptText: widget.promptText,
        topics: widget.topics,
        initialInteractionId: widget.initialInteractionId,
      ),
    );
  }
}
