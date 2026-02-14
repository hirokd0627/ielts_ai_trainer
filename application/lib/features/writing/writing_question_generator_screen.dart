import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_controller.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';

/// Question Generator Screen for Task 1 and 2.
class WritingQuestionGeneratorScreen extends StatefulWidget {
  /// The task type.
  final TestTask testTask;

  /// The prompt type to display initially, if set.
  final WritingPromptType? promptType;

  /// The prompt components to display initially, if set.
  final WritingPromptVo? writingPrompt;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingQuestionGeneratorScreen({
    super.key,
    required this.testTask,
    this.writingPrompt,
    this.topics,
    this.promptType,
  });

  @override
  State<WritingQuestionGeneratorScreen> createState() =>
      _WritingQuestionGeneratorScreenState();
}

/// State for WritingQuestionGeneratorScreen
class _WritingQuestionGeneratorScreenState
    extends State<WritingQuestionGeneratorScreen> {
  late final QuestionListController _questionListController;

  /// Returns the screen title based on the task type.
  String get _screenTitle {
    return widget.testTask == TestTask.writingTask1
        ? 'Writing Task 1'
        : 'Writing Task 2';
  }

  @override
  void initState() {
    super.initState();

    _questionListController = QuestionListController(
      queryService: QuestionListQueryService(context.read<AppDatabase>()),
      testTask: widget.testTask,
    );

    _loadInitialData();
  }

  /// Loads the initial data.
  Future<void> _loadInitialData() async {
    await _questionListController.refreshListRows();
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
                  topics: widget.topics,
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
