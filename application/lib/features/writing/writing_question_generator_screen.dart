import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';

/// Question Generator Screen for Task 1 and 2.
class WritingQuestionGeneratorScreen extends StatefulWidget {
  /// The task type.
  final TestTask testTask;

  /// The prompt type to display initially, if set.
  final WritingPromptType? promptType;

  /// The prompt components to display initially, if set.
  final WritingPromptVo? writingPrompt;

  /// The topic to display initially, if set.
  final String? topic;

  const WritingQuestionGeneratorScreen({
    super.key,
    required this.testTask,
    this.writingPrompt,
    this.topic,
    this.promptType,
  });

  @override
  State<WritingQuestionGeneratorScreen> createState() =>
      _WritingQuestionGeneratorScreenState();
}

/// State for WritingQuestionGeneratorScreen
class _WritingQuestionGeneratorScreenState
    extends State<WritingQuestionGeneratorScreen> {
  /// Returns the screen title based on the task type.
  String get _screenTitle {
    return widget.testTask == TestTask.writingTask1
        ? 'Writing Task 1'
        : 'Writing Task 2';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                WritingQuestionGeneratorForm(
                  testTask: widget.testTask,
                  writingPrompt: widget.writingPrompt,
                  topic: widget.topic,
                  promptType: widget.promptType,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
