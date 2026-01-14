import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_question_generator_controller.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
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
  late final WritingTask1QuestionGeneratorController _ctrl;
  final TextEditingController _topicTextEditCtrl = TextEditingController();
  final _focusNode = FocusNode();
  late final QuestionListController _questionListController;

  @override
  void initState() {
    super.initState();

    _ctrl = WritingTask1QuestionGeneratorController(
      apiSrv: WritingApiService(),
    );

    _questionListController = QuestionListController(
      queryService: QuestionListQueryService(context.read<AppDatabase>()),
    );

    _loadDate();
  }

  Future<void> _loadDate() async {
    await _questionListController.refreshListRows();
  }

  void _onSelectedQuestionType(String? value) {
    if (value != null) {
      _ctrl.questiontype = value;
    }
  }

  void _onSubmittedTopicsText(String value) {
    if (value.isEmpty) {
      return;
    }
    _ctrl.addTopic(value);
    _topicTextEditCtrl.clear();
    _focusNode.requestFocus(); // keep focus on text field
  }

  void _onDeleteChip(String topic) {
    _ctrl.removeTopic(topic);
  }

  void _onPressedGenerate() async {
    await _ctrl.generatePromptText();
  }

  void _onPressedStart() {
    // TODO: confirm
    // Pass prompt text and topics
    // These data saved when user submit answer
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BaseScreenScaffold(
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Type
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: ScreenTitlteText('Writing Task 1'),
                  ),
                  SizedBox(height: 24),
                  // Question type
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: FieldLabel('Question Type'),
                  ),
                  DropdownMenu<String>(
                    requestFocusOnTap: false,
                    hintText: 'Select question type',
                    initialSelection: null,
                    dropdownMenuEntries: WritingTask1QuestionType.values
                        .map(
                          (e) =>
                              DropdownMenuEntry(value: e.name, label: e.name),
                        )
                        .toList(),
                    onSelected: _onSelectedQuestionType,
                  ),
                  SizedBox(height: 24),
                  // Topics
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: FieldLabel('Topics'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        SizedBox(
                          width: screenWidth,
                          child: TextField(
                            // TODO: show errors if topics are duplicated
                            controller: _topicTextEditCtrl,
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter topic word and press enter key',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                            ),
                            onSubmitted: _onSubmittedTopicsText,
                          ),
                        ),
                        for (var topic in _ctrl.topics)
                          Chip(
                            label: Text(topic),
                            onDeleted: () => _onDeleteChip(topic),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  FilledButton(
                    onPressed: _ctrl.isGenerateButtonEnabled
                        ? _onPressedGenerate
                        : null,
                    child: const Text('Generate'),
                  ),
                  SizedBox(height: 36),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: HeadlineText('Question'),
                  ),
                  if (_ctrl.isPromptTextNotGenerated)
                    Text(
                      'Prompt will display here after entering topics and submit',
                    )
                  else if (_ctrl.isPromptTextGenerating)
                    Text('generating...')
                  else if (_ctrl.isPromptTextGenerated)
                    Text(_ctrl.propmtText),
                  SizedBox(height: 24),
                  FilledButton(
                    onPressed: _ctrl.isStartButtonEnabled
                        ? _onPressedStart
                        : null,
                    child: const Text('Start'),
                  ),
                ],
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
        },
      ),
    );
  }
}
