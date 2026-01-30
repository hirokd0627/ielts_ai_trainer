import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Controller for SpeakingQuestionGeneratorForm.
class SpeakingQuestionGeneratorFormController extends ChangeNotifier {
  /// Entered topics.
  final List<String> _topics;

  /// Topics used when generating the prompt text.
  final List<String> _usedTopics;

  /// Function to generate prompt text.
  /// Returns a record containing prompt text and a topics used.
  final Future<({List<String> topics, String promptText})> Function(
    int topicCount,
    List<String> topics,
  )
  _generatePromptText;

  /// The task type.
  final TestTask _testTask;

  /// The number of topics.
  int _topicCount;

  /// Generated prompt text.
  String _promptText = '';

  /// Processing state of prompt text generation.
  /// 0: not generated, 1: generating, 2: generated
  int _promptTextState = 0;

  SpeakingQuestionGeneratorFormController({
    required SpeakingApiService apiSrv,
    required Future<({List<String> topics, String promptText})> Function(
      int topicCount,
      List<String> topics,
    )
    generatePromptText,
    required TestTask testTask,
    String? promptText,
    List<String>? topics,
  }) : _generatePromptText = generatePromptText,
       _topics = topics != null ? List.from(topics) : [],
       _usedTopics = topics != null ? List.from(topics) : [],
       _topicCount = topics?.length ?? 0,
       _promptText = promptText ?? '',
       _promptTextState = (promptText != null) && promptText.isNotEmpty ? 2 : 0,
       _testTask = testTask;

  int get topicCount => _topicCount;

  List<String> get topics => _topics;

  List<String> get usedTopics => _usedTopics;

  String get promptText => _promptText;

  /// Whether the Generate button is enabled.
  bool get isGenerateButtonEnabled {
    if (_testTask == TestTask.speakingPart1) {
      // Part 1 requires the number of topics to be selected.
      return _topicCount > 0 &&
          _topics.length <= _topicCount &&
          !isPromptTextGenerating;
    }
    // Part 2 and Part 3 can generate prompt text without specifying the number of topics.
    return !isPromptTextGenerating;
  }

  /// Whether the Start button is enabled;
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

  /// Sets the number of topics.
  set topicCount(int value) {
    _topicCount = value;
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

  /// Validates the entered topics and returns an error message if the topics are invalid.
  String validateTopics(String? newTopic) {
    if (newTopic != null && _topics.contains(newTopic)) {
      return 'The entered topic has already been added.';
    }

    // Part 1 allows adding topics up to the specified topic count.
    // Part 2 and Part 3 allow adding topics up to a maximum of 10.
    int candidateTopicCount = newTopic == null
        ? _topics.length
        : _topics.length + 1; // consider the number of items to be added
    int maxTopicCount = 10;
    if (_testTask == TestTask.speakingPart1) {
      maxTopicCount = _topicCount;
    }
    if (candidateTopicCount > maxTopicCount) {
      return 'You can set up to $maxTopicCount topics.';
    }

    return '';
  }

  /// Generates prompt text using the entered topics.
  Future<void> generatePromptText() async {
    // TODO: dummy data
    _promptTextState = 1;
    notifyListeners();

    // TODO: error handling
    // Part 1 specifies the number of topics.
    // For Part 2 and Part 3, use the provided topics. If none are specified, one topic is generated at random.
    int topicCount = _topicCount;
    if (_testTask == TestTask.speakingPart2 ||
        _testTask == TestTask.speakingPart3) {
      topicCount = _topics.isEmpty ? 1 : _topics.length;
    }
    final generated = await _generatePromptText(topicCount, _topics);
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
