import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_screen.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Writing Task 2 Question Generator Screen.
class WritingTask2QuestionGeneratorScreen extends StatefulWidget {
  /// The prompt type to display initially, if set.
  final WritingPromptType? promptType;

  /// The prompt text to display initially, if set.
  // final String? promptText;
  final WritingPromptVo? writingPrompt;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingTask2QuestionGeneratorScreen({
    super.key,
    this.promptType,
    this.writingPrompt,
    this.topics,
  });

  @override
  State<WritingTask2QuestionGeneratorScreen> createState() =>
      _WritingTask2QuestionGeneratorScreenState();
}

/// State for WritingTask2QuestionGeneratorScreen
class _WritingTask2QuestionGeneratorScreenState
    extends State<WritingTask2QuestionGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: WritingQuestionGeneratorScreen(
        // onTappedStart: _onTappedStart,
        testTask: TestTask.writingTask2,
        promptType: widget.promptType,
        writingPrompt: widget.writingPrompt,
        topics: widget.topics,
      ),
    );
  }
}
