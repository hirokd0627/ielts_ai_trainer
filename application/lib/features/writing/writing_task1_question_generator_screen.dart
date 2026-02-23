import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 1 Question Generator Screen.
class WritingTask1QuestionGeneratorScreen extends StatefulWidget {
  /// The question type to display initially, if set.
  final WritingPromptType? promptType;

  /// The prompt components to display initially, if set.
  final WritingPromptVo? writingPrompt;

  /// The topic to display initially, if set.
  final String? topic;

  const WritingTask1QuestionGeneratorScreen({
    super.key,
    this.promptType,
    this.writingPrompt,
    this.topic,
  });

  @override
  State<WritingTask1QuestionGeneratorScreen> createState() =>
      _WritingTask1QuestionGeneratorScreenState();
}

/// State for WritingTask1QuestionGeneratorScreen
class _WritingTask1QuestionGeneratorScreenState
    extends State<WritingTask1QuestionGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: WritingQuestionGeneratorScreen(
        testTask: TestTask.writingTask1,
        promptType: widget.promptType,
        writingPrompt: widget.writingPrompt,
        topic: widget.topic,
      ),
    );
  }
}
