import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_form_controller.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/utils/dialog.dart';
import 'package:ielts_ai_trainer/shared/views/hover_highlight_text_field.dart';
import 'package:ielts_ai_trainer/shared/views/loading_indicator.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';

/// Question Generator Form for Speaking Tasks.
class SpeakingQuestionGeneratorForm extends StatefulWidget {
  /// Called when the Start button is tapped.
  final void Function(
    String promptText,
    List<String> topics,
    String interactionId,
  )
  onTappedStart;

  /// The task type.
  final TestTask testTask;

  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  /// ID issued when initial prompt was generated.
  final String? initialInteractionId;

  const SpeakingQuestionGeneratorForm({
    super.key,
    required this.onTappedStart,
    required this.testTask,
    this.promptText,
    this.topics,
    this.initialInteractionId,
  });

  @override
  State<SpeakingQuestionGeneratorForm> createState() =>
      _SpeakingQuestionGeneratorFormState();
}

/// State for SpeakingQuestionGeneratorForm.
class _SpeakingQuestionGeneratorFormState
    extends State<SpeakingQuestionGeneratorForm> {
  /// Controller for SpeakingQuestionGeneratorForm.
  late final SpeakingQuestionGeneratorFormController _ctrl;

  /// Controller for topic text field.
  final TextEditingController _topicTextEditCtrl = TextEditingController();

  /// Focus node for the topic text field.
  /// Keeps focus on the field after pressing Enter.
  final _focusNode = FocusNode();

  /// Input error text for topics.
  String _topicInputErrorText = '';

  /// Whether the mouse is on the topics area.
  bool _hoveringOnTopics = false;

  @override
  void initState() {
    super.initState();

    _ctrl = SpeakingQuestionGeneratorFormController(
      testTask: widget.testTask,
      apiSrv: SpeakingApiService(),
      promptText: widget.promptText,
      topics: widget.topics,
      interactionId: widget.initialInteractionId,
    );

    // Part 2 use only one topic.
    if (widget.testTask == TestTask.speakingPart2 && widget.topics != null) {
      widget.topics!.isNotEmpty ? widget.topics![0] : '';
      _topicTextEditCtrl.text = _ctrl.topic; // Set topic as initial display.
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _topicTextEditCtrl.dispose();

    super.dispose();
  }

  /// Called when the number of topics changes.
  void _onChangedTopicCount(int? value) {
    if (value != null) {
      _ctrl.topicCount = value;
    }

    if (!_validateTopics()) {
      return;
    }
  }

  /// Called when the topic is entered.
  void _onSubmittedTopicsText(String value) {
    _focusNode.requestFocus(); // keep focus on text field

    if (value.isEmpty) {
      return;
    }

    if (!_validateTopics(newValue: value)) {
      return;
    }

    _ctrl.addTopic(value);
    _topicTextEditCtrl.clear();
  }

  /// Called when the topic is changed.
  void _onChangedTopic(String value) {
    _ctrl.topic = value;
  }

  /// Called when the topic is deleted.
  void _onDeleteChip(String topic) {
    setState(() {
      _topicInputErrorText = '';
    });
    _ctrl.removeTopic(topic);
  }

  /// Called when the Generate button is tapped.
  void _onPressedGenerate() async {
    setState(() {
      _topicInputErrorText = '';
    });
    await _ctrl.generateInitialQuestion();
    if (widget.testTask == TestTask.speakingPart2) {
      _topicTextEditCtrl.text = _ctrl.topic;
    }
  }

  /// Called when the Start button is tapped.
  void _onPressedStart() async {
    // Confirm whether to start practicing.
    final confirmed = await showStartPracticeDialog(context);
    if (confirmed == null || !confirmed) {
      return;
    }

    if (!mounted) {
      // If state has been destroyed, context cannot be used, so return
      return;
    }

    if (widget.testTask == TestTask.speakingPart2) {
      widget.onTappedStart(_ctrl.promptText, [
        _ctrl.topic,
      ], _ctrl.interactionId);
    } else {
      widget.onTappedStart(_ctrl.promptText, _ctrl.topics, _ctrl.interactionId);
    }
  }

  /// Validates the entered topics, optionally including a new value.
  /// Returns true if the topics are valid, false otherwise.
  bool _validateTopics({String? newValue}) {
    final error = _ctrl.validateTopics(newValue);
    setState(() {
      _topicInputErrorText = error.isEmpty ? '' : error;
    });
    return error.isEmpty;
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
            // Number of Topics
            if (widget.testTask == TestTask.speakingPart1 ||
                widget.testTask == TestTask.speakingPart3)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: FieldLabel('Number of Topics'),
                  ),
                  SizedBox(height: 4),
                  RadioGroup<int>(
                    groupValue: _ctrl.topicCount,
                    onChanged: _onChangedTopicCount,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [1, 2, 3].map((int num) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<int>(
                              value: num,
                              enabled: !_ctrl.isPromptTextGenerating,
                            ),
                            Text("$num"),
                            SizedBox(width: 20),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            // Topics
            // If none are specified, topics are generated at random.
            Container(
              margin: EdgeInsets.only(bottom: 4),
              child: FieldLabel('Topics'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                widget.testTask == TestTask.speakingPart1 ||
                        widget.testTask == TestTask.speakingPart3
                    ? 'Missing topics will be auto-generated to reach the number of topics.'
                    : 'A topic will be auto-generated if left blank.',
                style: AppStyles.helperTextStyle,
              ),
            ),
            if (widget.testTask == TestTask.speakingPart2)
              HoverHighlightTextField(
                keyboardType: TextInputType.multiline,
                hintText: 'Type topic here...',
                onChanged: _onChangedTopic,
                controller: _topicTextEditCtrl,
                enabled: !_ctrl.isPromptTextGenerating,
                maxLines: 1,
              )
            else
              MouseRegion(
                onEnter: (_) => setState(() => _hoveringOnTopics = true),
                onExit: (_) => setState(() => _hoveringOnTopics = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: (_topicInputErrorText.isEmpty)
                        ? ((_hoveringOnTopics && !_ctrl.isPromptTextGenerating)
                              ? Border.all(color: AppColors.focusColor)
                              : Border.all(color: AppColors.borderColor))
                        : Border.all(color: AppColors.errorRed),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      SizedBox(
                        width: screenWidth,
                        child: TextField(
                          enabled: !_ctrl.isPromptTextGenerating,
                          controller: _topicTextEditCtrl,
                          focusNode: _focusNode,
                          style: AppStyles.textFieldStyle(
                            context,
                            enabled: !_ctrl.isPromptTextGenerating,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a topic and press Enter',
                            hintStyle: AppStyles.placeHolderText,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 2,
                            ),
                          ),
                          onSubmitted: _onSubmittedTopicsText,
                        ),
                      ),
                      for (var topic in _ctrl.topics)
                        Chip(
                          label: Text(
                            topic,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColors.textColor,
                            ),
                          ),
                          backgroundColor: AppColors.chipBackground,
                          onDeleted: _ctrl.isPromptTextGenerating
                              ? null
                              : () => _onDeleteChip(topic),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          deleteIcon: Icon(Icons.close),
                          deleteButtonTooltipMessage: 'Remove',
                        ),
                    ],
                  ),
                ),
              ),
            if (_topicInputErrorText.isNotEmpty)
              InputErrorText(_topicInputErrorText),
            SizedBox(height: 20),
            FilledButton(
              onPressed: _ctrl.isGenerateButtonEnabled
                  ? _onPressedGenerate
                  : null,
              child: const Text('Generate'),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: HeadlineText('Question'),
            ),
            Container(
              child: (_ctrl.isPromptTextNotGenerated)
                  ? Text(
                      'Prompt will display here after entering topics and submit',
                    )
                  : (_ctrl.isPromptTextGenerating)
                  ? LoadingIndicator('Generating...')
                  : Text(_ctrl.promptText),
            ),
            SizedBox(height: 20),
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
