import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Controller for SpeakingQuestionGeneratorForm.
class SpeakingQuestionGeneratorFormController extends ChangeNotifier {
  /// API service to generate prompt text.
  final SpeakingApiService _apiSrv = SpeakingApiService();

  /// Entered topics.
  final List<String> _topics;

  /// Topics used when generating the prompt text.
  final List<String> _usedTopics;

  /// The task type.
  final TestTask _testTask;

  /// The number of topics.
  int _topicCount;

  /// Generated prompt text.
  String _promptText = '';

  /// Processing state of prompt text generation.
  /// 0: not generated, 1: generating, 2: generated
  int _promptTextState = 0;

  /// ID to identify conversation.
  String _interactionId = '';

  SpeakingQuestionGeneratorFormController({
    required SpeakingApiService apiSrv,
    required TestTask testTask,
    String? promptText,
    List<String>? topics,
  }) : _topics = topics != null ? List.from(topics) : [],
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
    if (_testTask == TestTask.speakingPart1 ||
        _testTask == TestTask.speakingPart3) {
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

  String get interactionId => _interactionId;

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

    // Part 1 and Part 3 allow adding topics up to the specified topic count.
    // Part 2 allows adding topics up to a maximum of 10.
    int candidateTopicCount = newTopic == null
        ? _topics.length
        : _topics.length + 1; // consider the number of items to be added
    int maxTopicCount = 10;
    if (_testTask == TestTask.speakingPart1 ||
        _testTask == TestTask.speakingPart3) {
      maxTopicCount = _topicCount;
    }
    if (candidateTopicCount > maxTopicCount) {
      return 'You can set up to $maxTopicCount topics.';
    }

    return '';
  }

  /// Generates prompt text using the entered topics.
  Future<void> generateInitialQuestion() async {
    // Update screen.
    _promptTextState = 1;
    notifyListeners();

    // Generate topics if not entered.
    // Part 1 and Part 3 specifies the number of topics, Part 2 uses only one topic.
    int addTopicCount = 0;
    if (_testTask == TestTask.speakingPart1 ||
        _testTask == TestTask.speakingPart3) {
      addTopicCount = _topicCount - _topics.length;
    } else if (_testTask == TestTask.speakingPart2) {
      addTopicCount = 1;
    }
    final topics = addTopicCount > 0
        ? [..._topics, ...(await _apiSrv.generateTopics(addTopicCount))]
        : [..._topics];

    // Generate question.
    if (_testTask == TestTask.speakingPart1 ||
        _testTask == TestTask.speakingPart3) {
      final resp = await _apiSrv.generateInitialQuestion(
        _testTask.number,
        topics[0],
      );
      _promptText = resp.question;
      _interactionId = resp.interactionId;
    } else if (_testTask == TestTask.speakingPart2) {
      final resp = await _apiSrv.generatePart2CuecardContent(
        topics.isNotEmpty ? topics.first : '',
      );
      _promptText = resp.prompt;
    }

    // Store topics to show on screen.
    _topics.clear();
    _topics.addAll(topics);

    // Store topics used in generating
    _usedTopics.clear();
    _usedTopics.addAll(topics);

    // Update screen.
    _promptTextState = 2;
    notifyListeners();
  }
}
