import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';

class WritingTask1QuestionGeneratorController extends ChangeNotifier {
  // final WritingQueryService _queryService;
  final WritingApiService _apiSrv;

  final List<String> _topics = [];

  /// Topics used when generating the prompt text
  final List<String> _usedTopics = [];

  String _questionType = '';
  String _promptText = '';

  int _promptTextState = 0; // 0: not generated, 1: generating, 2: generated

  WritingTask1QuestionGeneratorController({required WritingApiService apiSrv})
    : _apiSrv = apiSrv;

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

    final resp = await _apiSrv.generatePromptText(_topics);
    // TODO: error handling
    _promptText = resp.promptText;
    _usedTopics.clear();
    _usedTopics.addAll(_topics); // store topics used generating

    _promptTextState = 2;
    notifyListeners();
  }
}
