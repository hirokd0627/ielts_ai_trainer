import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form_controller.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task2_essay_type.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';

/// Question Generator Form for Writing Tasks.
class WritingQuestionGeneratorForm extends StatefulWidget {
  /// Called when generation button is tapped.
  final Future<String> Function(List<String> topics) generatePromptText;

  /// Called when start button is tapped.
  final void Function(String promptText, List<String> topics) onTappedStart;

  /// The task type.
  final TestTask testTask;

  const WritingQuestionGeneratorForm({
    super.key,
    required this.generatePromptText,
    required this.onTappedStart,
    required this.testTask,
  });

  @override
  State<WritingQuestionGeneratorForm> createState() =>
      _WritingQuestionGeneratorFormState();
}

/// State for WritingTaskQuestionGeneratorForm.
class _WritingQuestionGeneratorFormState
    extends State<WritingQuestionGeneratorForm> {
  /// Controller for WritingQuestionGeneratorForm.
  late final WritingQuestionGeneratorFormController _ctrl;

  /// Controller for topic text field.
  final TextEditingController _topicTextEditCtrl = TextEditingController();

  /// Focus node for the topic text field.
  /// Keeps focus on the field after pressing Enter.
  final _focusNode = FocusNode();

  /// Input error text for topics.
  String _topicInputErrorText = '';

  /// Returns the label for the prompt type based on the test task.
  String get _promptTypeLabel {
    if (widget.testTask == TestTask.writingTask1) {
      return 'Question Type';
    }
    return 'Essay Type';
  }

  /// Options for prompt type.
  List<DropdownMenuEntry<String>> get _promptTypeEntries {
    if (widget.testTask == TestTask.writingTask1) {
      return WritingTask1QuestionType.values.map((e) {
        String label = switch (e) {
          WritingTask1QuestionType.chart => 'Chart',
          WritingTask1QuestionType.graph => 'Graph',
          WritingTask1QuestionType.map => 'Map',
          WritingTask1QuestionType.process => 'Process',
          WritingTask1QuestionType.table => 'Table',
        };
        return DropdownMenuEntry(value: e.name, label: label);
      }).toList();
    }
    return WritingTask2EssayType.values.map((e) {
      String label = switch (e) {
        WritingTask2EssayType.discussionEssay => 'Discussion Essay',
        WritingTask2EssayType.problemAndSolution => 'Problem and Solution',
        WritingTask2EssayType.opinionEssay =>
          'Opinion Essay (Agree or Disagree)',
        WritingTask2EssayType.twoPartQuestionEssay => 'Two-part Question Essay',
        WritingTask2EssayType.advantagesAndDisadvantages =>
          'Advantages and Disadvantages',
      };
      return DropdownMenuEntry(value: e.name, label: label);
    }).toList();
  }

  /// Hint text for prompt type.
  String get _promptTypeHintText {
    return widget.testTask == TestTask.writingTask1
        ? 'Select question type'
        : 'Select essay type';
  }

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
  void _onSelectedPromptType(String? value) {
    if (value != null) {
      _ctrl.promptType = value;
    }
  }

  /// Called when the topic is entered.
  void _onSubmittedTopicsText(String value) {
    _focusNode.requestFocus(); // keep focus on text field

    if (value.isEmpty) {
      return;
    }
    final error = _ctrl.validateTopics(value);
    if (error.isNotEmpty) {
      setState(() {
        _topicInputErrorText = error;
      });
      return;
    }
    setState(() {
      _topicInputErrorText = '';
    });

    _ctrl.addTopic(value);
    _topicTextEditCtrl.clear();
    // _focusNode.requestFocus(); // keep focus on text field
  }

  /// Called when the topic is deleted.
  void _onDeleteChip(String topic) {
    setState(() {
      _topicInputErrorText = '';
    });
    _ctrl.removeTopic(topic);
  }

  /// Called when the generate button is tapped.
  void _onPressedGenerate() async {
    setState(() {
      _topicInputErrorText = '';
    });
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
              child: FieldLabel(_promptTypeLabel),
            ),
            DropdownMenu<String>(
              width: 250,
              requestFocusOnTap: false,
              hintText: _promptTypeHintText,
              initialSelection: null,
              dropdownMenuEntries: _promptTypeEntries,
              onSelected: _onSelectedPromptType,
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
                border: (_topicInputErrorText.isEmpty)
                    ? Border.all(color: Colors.grey)
                    : Border.all(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  SizedBox(
                    width: screenWidth,
                    child: TextField(
                      controller: _topicTextEditCtrl,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a topic and press Enter',
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
            if (_topicInputErrorText.isNotEmpty)
              InputErrorText(_topicInputErrorText),
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
