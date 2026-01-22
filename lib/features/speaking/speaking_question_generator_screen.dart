import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_form.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_controller.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';

/// Question Generator Screen for Part 1, Part 2, and Part 3.
class SpeakingQuestionGeneratorScreen extends StatefulWidget {
  /// Function to generate a prompt text.
  /// Called when the Generate button is tapped.
  /// Returns a record containing a prompt text and a topics used.
  final Future<({List<String> topics, String promptText})> Function(
    int topicCount,
    List<String> topics,
  )
  generatePromptText;

  /// Called when the Start button is tapped.
  final void Function(String promptText, List<String> topics) onTappedStart;

  /// The task type.
  final TestTask testTask;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const SpeakingQuestionGeneratorScreen({
    super.key,
    required this.generatePromptText,
    required this.onTappedStart,
    required this.testTask,
    this.promptText,
    this.topics,
  });

  @override
  State<SpeakingQuestionGeneratorScreen> createState() =>
      _SpeakingQuestionGeneratorScreenState();
}

/// State for SpeakingQuestionGeneratorScreen
class _SpeakingQuestionGeneratorScreenState
    extends State<SpeakingQuestionGeneratorScreen> {
  /// Controller for QuestionListView
  late final QuestionListController _questionListController;

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
                generatePromptText: widget.generatePromptText,
                onTappedStart: widget.onTappedStart,
                testTask: widget.testTask,
                promptText: widget.promptText,
                topics: widget.topics,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
        // Question List
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppStyles.screenPadding,
                ),
                child: HeadlineText("Solved Questions"),
              ),
              SizedBox(height: 20),
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
