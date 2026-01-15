import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';

class WritingQuestionGeneratorFormController extends ChangeNotifier {
  final List<String> _topics = [];

  /// Topics used when generating the prompt text
  final List<String> _usedTopics = [];

  final Future<String> Function(List<String> topics) _generatePromptText;

  String _questionType = '';
  String _promptText = '';

  int _promptTextState = 0; // 0: not generated, 1: generating, 2: generated

  WritingQuestionGeneratorFormController({
    required WritingApiService apiSrv,
    required Future<String> Function(List<String> topics) generatePromptText,
  }) : _generatePromptText = generatePromptText;

  List<String> get topics => _topics;
  List<String> get usedTopics => _usedTopics;
  String get propmtText => _promptText;

  bool get isGenerateButtonEnabled {
    return _questionType.isNotEmpty && _topics.isNotEmpty;
  }

  bool get isStartButtonEnabled {
    return _promptText.isNotEmpty && isPromptTextGenerated;
  }

  bool get isPromptTextNotGenerated {
    return _promptTextState == 0;
  }

  bool get isPromptTextGenerating {
    return _promptTextState == 1;
  }

  bool get isPromptTextGenerated {
    return _promptTextState == 2;
  }

  void addTopic(String topic) {
    _topics.add(topic);
    notifyListeners();
  }

  void removeTopic(String topic) {
    _topics.remove(topic);
    notifyListeners();
  }

  String get questionType => _questionType;

  set questiontype(String value) {
    _questionType = value.trim();
    notifyListeners();
  }

  Future<void> generatePromptText() async {
    // TODO: dummy data
    _promptTextState = 1;
    notifyListeners();

    // TODO: error handling
    _promptText = await _generatePromptText(topics);
    _usedTopics.clear();
    _usedTopics.addAll(_topics); // store topics used generating

    _promptTextState = 2;
    notifyListeners();
  }
}
