import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/setting/app_settings.dart';
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/views/controller_exception.dart';

/// Controller for SpeakingQuestionGeneratorForm.
class SpeakingQuestionGeneratorFormController extends ChangeNotifier {
  final _logger = createLogger('SpeakingQuestionGeneratorFormController');

  /// API service to generate prompt.
  final SpeakingApiService _apiSrv = SpeakingApiService();

  /// Entered topics.
  final List<String> _topics;

  /// The task type.
  final TestTask _testTask;

  /// The number of topics.
  int _topicCount;

  /// Generated prompt text.
  String _promptText;

  /// Processing state of prompt text generation.
  /// 0: not generated, 1: generating, 2: generated
  int _promptTextState;

  /// ID to identify conversation.
  String _interactionId;

  SpeakingQuestionGeneratorFormController({
    required SpeakingApiService apiSrv,
    required TestTask testTask,
    String? promptText,
    List<String>? topics,
    String? interactionId,
  }) : _topics = topics != null ? List.from(topics) : [],
       _topicCount = topics?.length ?? 0,
       _promptText = promptText ?? '',
       _promptTextState = (promptText != null) && promptText.isNotEmpty ? 2 : 0,
       _testTask = testTask,
       _interactionId = interactionId ?? '';

  int get topicCount => _topicCount;

  List<String> get topics => _topics;

  String get topic => _topics.isNotEmpty ? _topics[0] : '';

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
  bool get isPromptTextNotGenerated => _promptTextState == 0;

  /// Whether the prompt text is being generated.
  bool get isPromptTextGenerating => _promptTextState == 1;

  /// Whether the prompt text has been generated.
  bool get isPromptTextGenerated => _promptTextState == 2;

  /// Whether the prompt generation has been failed.
  bool get isPromptTextGeneratedFailed => _promptTextState == 3;

  String get interactionId => _interactionId;

  /// Sets topic.
  set topic(String value) {
    if (_topics.isEmpty) {
      _topics.add('');
    }
    _topics[0] = value;
    notifyListeners();
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

    try {
      // Generate topics if not entered.
      // Part 1 and Part 3 specifies the number of topics, Part 2 uses only one topic.
      if (_testTask == TestTask.speakingPart2) {
        if (topic.isEmpty) {
          final topics = await _apiSrv.generateTopics(
            1,
            AppSettings.instance.aiAgent,
          );
          _topics.add(topics[0]);
          // Update screen beforehand.
          notifyListeners();
        }

        // Generate question.
        final resp = await _apiSrv.generatePart2CuecardContent(
          _topics[0],
          AppSettings.instance.aiAgent,
        );
        _promptText = resp.prompt;
      } else {
        int addTopicCount = 0;
        if (_testTask == TestTask.speakingPart1 ||
            _testTask == TestTask.speakingPart3) {
          addTopicCount = _topicCount - _topics.length;
        }
        if (addTopicCount > 0) {
          final additionalTopics = await _apiSrv.generateTopics(
            addTopicCount,
            AppSettings.instance.aiAgent,
            excludeTopics: topics,
          );
          _topics.addAll(additionalTopics);
          // Update screen beforehand.
          notifyListeners();
        }

        // Generate question.
        final resp = await _apiSrv.generateInitialQuestion(
          _testTask.number,
          topics[0],
          AppSettings.instance.aiAgent,
        );
        _promptText = resp.question;
        _interactionId = resp.interactionId;
      }
      _promptTextState = 2;
    } catch (e, s) {
      _promptTextState = 3;
      _logger.e(e, stackTrace: s);
      throw ControllerException(
        'generate question error',
        exception: e,
        stackTrace: s,
      );
    } finally {
      // Update screen.
      notifyListeners();
    }
  }
}
