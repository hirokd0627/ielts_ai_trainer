import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task2_essay_type.dart';

/// Controller for WritingQuestionGeneratorForm.
class WritingQuestionGeneratorFormController extends ChangeNotifier {
  /// The task type.
  final TestTask _testTask;

  /// Entered topics.
  final List<String> _topics;

  /// Topics used when generating the prompt text.
  final List<String> _usedTopics;

  /// Function to generate prompt Text.
  final Future<String> Function(dynamic promptType, List<String> topics)
  _generatePromptText;

  /// Selected question type.
  WritingTask1QuestionType? _questionType;

  /// Selected essay type.
  WritingTask2EssayType? _essayType;

  /// Generated prompt text.
  String _promptText = '';

  /// Processing state of prompt text generation.
  /// 0: not generated, 1: generating, 2: generated
  int _promptTextState = 0;

  WritingQuestionGeneratorFormController({
    required WritingApiService apiSrv,
    required Future<String> Function(dynamic promptType, List<String> topics)
    generatePromptText,
    required TestTask testTask,
    String? promptText,
    List<String>? topics,
    WritingTask1QuestionType? questionType,
    WritingTask2EssayType? essayType,
  }) : _testTask = testTask,
       _generatePromptText = generatePromptText,
       _topics = topics != null ? List.from(topics) : [],
       _usedTopics = topics != null ? List.from(topics) : [],
       _questionType = questionType,
       _essayType = essayType {
    _promptText = promptText ?? '';
    _promptTextState = (promptText != null) && promptText.isNotEmpty ? 2 : 0;
  }

  WritingTask1QuestionType? get questionType => _questionType;

  WritingTask2EssayType? get essayType => _essayType;

  List<String> get topics => _topics;

  List<String> get usedTopics => _usedTopics;

  String get propmtText => _promptText;

  /// Whether the generate button is enabled.
  bool get isGenerateButtonEnabled {
    if (_topics.isEmpty) {
      return false;
    }
    if (_testTask == TestTask.writingTask1) {
      return _questionType != null;
    }
    return _essayType != null;
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

  /// Sets the selected question type.
  set questionType(WritingTask1QuestionType value) {
    _questionType = value;
    notifyListeners();
  }

  /// Sets the selected essay type.
  set essayType(WritingTask2EssayType value) {
    _essayType = value;
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
    if (_testTask == TestTask.writingTask1) {
      _promptText = await _generatePromptText(_questionType, _topics);
    } else {
      _promptText = await _generatePromptText(_essayType, _topics);
    }
    _usedTopics.clear();
    _usedTopics.addAll(_topics); // store topics used generating

    _promptTextState = 2;
    notifyListeners();
  }
}
