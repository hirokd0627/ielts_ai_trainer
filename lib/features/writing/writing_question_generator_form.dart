import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form_controller.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';

/// Question Generator Form for Writing Tasks
class WritingQuestionGeneratorForm extends StatefulWidget {
  /// Called when generation button is tapped.
  final Future<String> Function(List<String> topics) generatePromptText;

  /// Called when start button is tapped.
  final void Function(String promptText, List<String> topics) onTappedStart;

  const WritingQuestionGeneratorForm({
    super.key,
    required this.generatePromptText,
    required this.onTappedStart,
  });

  @override
  State<WritingQuestionGeneratorForm> createState() =>
      _WritingQuestionGeneratorFormState();
}

/// State for WritingTaskQuestionGeneratorForm
class _WritingQuestionGeneratorFormState
    extends State<WritingQuestionGeneratorForm> {
  /// Controller for WritingQuestionGeneratorForm
  late final WritingQuestionGeneratorFormController _ctrl;

  /// Controller for topic text field
  final TextEditingController _topicTextEditCtrl = TextEditingController();

  /// Focus to control to input topic.
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _ctrl = WritingQuestionGeneratorFormController(
      apiSrv: WritingApiService(),
      generatePromptText: widget.generatePromptText,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _topicTextEditCtrl.dispose();

    super.dispose();
  }

  /// Called when the question type is changed.
  void _onSelectedQuestionType(String? value) {
    if (value != null) {
      _ctrl.questiontype = value;
    }
  }

  /// Called when the topic is entered.
  void _onSubmittedTopicsText(String value) {
    if (value.isEmpty) {
      return;
    }
    _ctrl.addTopic(value);
    _topicTextEditCtrl.clear();
    _focusNode.requestFocus(); // keep focus on text field
  }

  /// Called when the topic is deleted.
  void _onDeleteChip(String topic) {
    _ctrl.removeTopic(topic);
  }

  /// Called when the generate button is tapped.
  void _onPressedGenerate() async {
    await _ctrl.generatePromptText();
  }

  /// Called when the start button is tapped.
  void _onPressedStart() {
    // TODO: confirm
    // Pass prompt text and topics
    // These data saved when user submit answer
    widget.onTappedStart(_ctrl.propmtText, _ctrl.usedTopics);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  .map((e) => DropdownMenuEntry(value: e.name, label: e.name))
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
              Text('Prompt will display here after entering topics and submit')
            else if (_ctrl.isPromptTextGenerating)
              Text('generating...')
            else if (_ctrl.isPromptTextGenerated)
              Text(_ctrl.propmtText),
            SizedBox(height: 24),
            FilledButton(
              onPressed: _ctrl.isStartButtonEnabled ? _onPressedStart : null,
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }
}
