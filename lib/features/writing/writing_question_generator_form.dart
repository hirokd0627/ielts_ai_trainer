import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_question_generator_form_controller.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task2_essay_type.dart';
import 'package:ielts_ai_trainer/shared/utils/dialog.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';

/// Question Generator Form for Writing Tasks.
class WritingQuestionGeneratorForm extends StatefulWidget {
  /// Called when generation button is tapped.
  final Future<String> Function(dynamic promptType, List<String> topics)
  generatePromptText;

  /// Called when start button is tapped.
  final void Function(
    String promptText,
    List<String> topics,
    dynamic promptType,
  )
  onTappedStart;

  /// The task type.
  final TestTask testTask;

  /// The question type to display initially, if set.
  final WritingTask1QuestionType? questionType;

  /// The essay type to display initially, if set.
  final WritingTask2EssayType? essayType;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const WritingQuestionGeneratorForm({
    super.key,
    required this.generatePromptText,
    required this.onTappedStart,
    required this.testTask,
    this.promptText,
    this.topics,
    this.questionType,
    this.essayType,
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

  /// Options for question type.
  List<DropdownMenuEntry<WritingTask1QuestionType>> get _questionTypeEntries {
    return WritingTask1QuestionType.values.map((e) {
      String label = switch (e) {
        WritingTask1QuestionType.chart => 'Chart',
        WritingTask1QuestionType.graph => 'Graph',
        WritingTask1QuestionType.map => 'Map',
        WritingTask1QuestionType.process => 'Process',
        WritingTask1QuestionType.table => 'Table',
      };
      return DropdownMenuEntry(value: e, label: label);
    }).toList();
  }

  /// Options for essay type.
  List<DropdownMenuEntry<WritingTask2EssayType>> get _essayTypeEntries {
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
      return DropdownMenuEntry(value: e, label: label);
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
      testTask: widget.testTask,
      apiSrv: WritingApiService(),
      generatePromptText: widget.generatePromptText,
      promptText: widget.promptText,
      topics: widget.topics,
      questionType: widget.questionType,
      essayType: widget.essayType,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _topicTextEditCtrl.dispose();

    super.dispose();
  }

  /// Called when the question type is changed.
  void _onSelectedQuetionType(WritingTask1QuestionType? value) {
    if (value != null) {
      _ctrl.questionType = value;
    }
  }

  /// Called when the essay type is changed.
  void _onSelectedEssayType(WritingTask2EssayType? value) {
    if (value != null) {
      _ctrl.essayType = value;
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
  void _onPressedStart() async {
    // Confirm whether to start practicing.
    final confirmed = await showConfirmDialog(
      context,
      'Start to practice?',
      '',
    );
    if (confirmed == null || !confirmed) {
      return;
    }

    if (!mounted) {
      // If state has been destroyed, context cannot be used, so return
      return;
    }

    final promptType = (widget.testTask == TestTask.writingTask1)
        ? _ctrl.questionType
        : _ctrl.essayType;
    widget.onTappedStart(_ctrl.propmtText, _ctrl.usedTopics, promptType);
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
            if (widget.testTask == TestTask.writingTask1)
              DropdownMenu<WritingTask1QuestionType>(
                width: 250,
                requestFocusOnTap: false,
                hintText: _promptTypeHintText,
                initialSelection: _ctrl.questionType,
                dropdownMenuEntries: _questionTypeEntries,
                onSelected: _onSelectedQuetionType,
              )
            else if (widget.testTask == TestTask.writingTask2)
              DropdownMenu<WritingTask2EssayType>(
                width: 250,
                requestFocusOnTap: false,
                hintText: _promptTypeHintText,
                initialSelection: _ctrl.essayType,
                dropdownMenuEntries: _essayTypeEntries,
                onSelected: _onSelectedEssayType,
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
