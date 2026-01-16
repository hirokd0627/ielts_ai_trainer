import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_controller.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';

/// Question Generator Screen for Task 1 and 2.
class WritingQuestionGeneratorScreen extends StatefulWidget {
  /// Called when generation button is tapped.
  final Future<String> Function(List<String> topics) generatePromptText;

  /// Called when start button is tapped.
  final void Function(String promptText, List<String> topics) onTappedStart;

  /// The task type.
  final TestTask testTask;

  const WritingQuestionGeneratorScreen({
    super.key,
    required this.generatePromptText,
    required this.onTappedStart,
    required this.testTask,
  });

  @override
  State<WritingQuestionGeneratorScreen> createState() =>
      _WritingQuestionGeneratorScreenState();
}

/// State for WritingQuestionGeneratorScreen
class _WritingQuestionGeneratorScreenState
    extends State<WritingQuestionGeneratorScreen> {
  /// Controller for QuestionListView
  late final QuestionListController _questionListController;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          padding: EdgeInsets.only(top: 20),
          child: ScreenTitleText(_screenTitle),
        ),
        SizedBox(height: 24),
        // Question Generator Form
        WritingQuestionGeneratorForm(
          generatePromptText: widget.generatePromptText,
          onTappedStart: widget.onTappedStart,
          testTask: widget.testTask,
        ),
        SizedBox(height: 40),
        // Question List
        Expanded(
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [HeadlineText("Solved Questions")],
              ),
              // Question list
              Expanded(
                child: QuestionListView(
                  searchBarEnabled: false,
                  controller: _questionListController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
