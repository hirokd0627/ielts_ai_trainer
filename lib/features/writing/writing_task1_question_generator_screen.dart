import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_controller.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';

class WritingTask1QuestionGeneratorScreen extends StatefulWidget {
  const WritingTask1QuestionGeneratorScreen({super.key});

  @override
  State<WritingTask1QuestionGeneratorScreen> createState() =>
      _WritingTask1QuestionGeneratorScreenState();
}

/// State for WritingTask1QuestionGeneratorScreen
class _WritingTask1QuestionGeneratorScreenState
    extends State<WritingTask1QuestionGeneratorScreen> {
  /// API service to generate prompt text
  final WritingApiService _apiSrv = WritingApiService();

  /// Controller for QuestionListView
  late final QuestionListController _questionListController;

  @override
  void initState() {
    super.initState();

    _questionListController = QuestionListController(
      queryService: QuestionListQueryService(context.read<AppDatabase>()),
    );

    _loadInitialData();
  }

  /// Loads the initial data.
  Future<void> _loadInitialData() async {
    await _questionListController.refreshListRows();
  }

  /// Generates the prompt text.
  ///
  /// Called when generation button is tapped.
  Future<String> _generatePromptText(List<String> topics) async {
    final resp = await _apiSrv.generatePromptText(topics);
    // TODO: error handling
    return resp.promptText;
  }

  /// Called when start button is tapped.
  void _onTappedStart(_, _) {
    // TODO: navigate to answer input screen
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Container(
            padding: EdgeInsets.only(top: 20),
            child: ScreenTitlteText('Writing Task 1'),
          ),
          SizedBox(height: 24),
          // Question Generator Form
          WritingQuestionGeneratorForm(
            generatePromptText: _generatePromptText,
            onTappedStart: _onTappedStart,
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
      ),
    );
  }
}
