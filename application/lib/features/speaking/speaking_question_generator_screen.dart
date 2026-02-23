import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_form.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';

/// Question Generator Screen for Part 1, Part 2, and Part 3.
class SpeakingQuestionGeneratorScreen extends StatefulWidget {
  /// Called when the Start button is tapped.
  final void Function(
    String promptText,
    List<String> topics,
    String interactionId,
  )
  onTappedStart;

  /// The task type.
  final TestTask testTask;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  /// ID issued when initial prompt was generated.
  final String? initialInteractionId;

  const SpeakingQuestionGeneratorScreen({
    super.key,
    required this.onTappedStart,
    required this.testTask,
    this.promptText,
    this.topics,
    this.initialInteractionId,
  });

  @override
  State<SpeakingQuestionGeneratorScreen> createState() =>
      _SpeakingQuestionGeneratorScreenState();
}

/// State for SpeakingQuestionGeneratorScreen
class _SpeakingQuestionGeneratorScreenState
    extends State<SpeakingQuestionGeneratorScreen> {
  /// Returns the screen title based on the task type.
  String get _screenTitle {
    if (widget.testTask == TestTask.speakingPart1) {}
    return widget.testTask == TestTask.speakingPart1
        ? 'Speaking Part 1'
        : widget.testTask == TestTask.speakingPart2
        ? 'Speaking Part 2'
        : 'Speaking Part 3';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppStyles.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              // Title
              ScreenTitleText(_screenTitle),
              SizedBox(height: 20),
              // Question Generator Form
              SpeakingQuestionGeneratorForm(
                onTappedStart: widget.onTappedStart,
                testTask: widget.testTask,
                promptText: widget.promptText,
                topics: widget.topics,
                initialInteractionId: widget.initialInteractionId,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
