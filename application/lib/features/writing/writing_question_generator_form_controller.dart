import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

/// Controller for WritingQuestionGeneratorForm.
class WritingQuestionGeneratorFormController extends ChangeNotifier {
  /// Entered topics.
  final List<String> _topics;

  /// Topics used when generating the prompt text.
  final List<String> _usedTopics;

  /// Function to generate prompt Text.
  /// Returns a record containing prompt text and topics used.
  final Future<({List<String> topics, String promptText})> Function(
    WritingPromptType promptType,
    List<String> topics,
  )
  _generatePromptText;

  /// Selected prompt type.
  WritingPromptType? _promptType;

  /// Generated prompt text.
  String _promptText = '';

  /// Processing state of prompt text generation.
  /// 0: not generated, 1: generating, 2: generated
  int _promptTextState = 0;

  WritingQuestionGeneratorFormController({
    required WritingApiService apiSrv,
    required Future<({List<String> topics, String promptText})> Function(
      WritingPromptType promptType,
      List<String> topics,
    )
    generatePromptText,
    required TestTask testTask,
    String? promptText,
    List<String>? topics,
    WritingPromptType? promptType,
  }) : _generatePromptText = generatePromptText,
       _topics = topics != null ? List.from(topics) : [],
       _usedTopics = topics != null ? List.from(topics) : [],
       _promptType = promptType {
    _promptText = promptText ?? '';
    _promptTextState = (promptText != null) && promptText.isNotEmpty ? 2 : 0;
  }

  WritingPromptType? get promptType => _promptType;

  List<String> get topics => _topics;

  List<String> get usedTopics => _usedTopics;

  String get propmtText => _promptText;

  /// Whether the generate button is enabled.
  bool get isGenerateButtonEnabled {
    return _promptType != null;
  }

  /// Whether the start button is enabled;
  bool get isStartButtonEnabled {
    return _promptText.isNotEmpty && isPromptTextGenerated;
  }

  /// Whether the prompt text has not been generated yet.
  bool get isPromptTextNotGenerated {
    return _promptTextState == 0;
  }

  /// Whether the prompt text is being generated.
  bool get isPromptTextGenerating {
    return _promptTextState == 1;
  }

  /// Whether the prompt text has been generated.
  bool get isPromptTextGenerated {
    return _promptTextState == 2;
  }

  /// Sets the selected prompt type.
  set promptType(WritingPromptType value) {
    _promptType = value;
    notifyListeners();
  }

  /// Adds a new topic to the entered topic list.
  void addTopic(String topic) {
    _topics.add(topic);
    notifyListeners();
  }

  /// Removes the given topic from the entered topic list.
  void removeTopic(String topic) {
    _topics.remove(topic);
    notifyListeners();
  }

  /// Validates a new topic and returns an error message if invalid.
  String validateTopics(String newTopic) {
    if (_topics.contains(newTopic)) {
      return 'The entered topic has already been added.';
    }
    if (_topics.length >= 3) {
      return 'You can set up to three topics.';
    }
    return '';
  }

  /// Generates the prompt text using the entered topics.
  Future<void> generatePromptText() async {
    // TODO: dummy data
    _promptTextState = 1;
    notifyListeners();

    // TODO: error handling
    final generated = await _generatePromptText(_promptType!, _topics);
    _promptText = generated.promptText;

    _usedTopics.clear();
    _usedTopics.addAll(generated.topics); // store topics used generating

    // show used topics on screen
    _topics.clear();
    _topics.addAll(generated.topics);

    _promptTextState = 2;
    notifyListeners();
  }
}
