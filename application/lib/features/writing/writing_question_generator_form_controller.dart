import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_diagram_service.dart';
import 'package:ielts_ai_trainer/shared/api/writing_prompt_type_api_extension.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

/// Controller for WritingQuestionGeneratorForm.
class WritingQuestionGeneratorFormController extends ChangeNotifier {
  /// Entered topics.
  final List<String> _topics;

  /// Topics used when generating the prompt text.
  final List<String> _usedTopics;

  /// API service to generate prompt text
  final WritingApiService _apiSrv = WritingApiService();

  final WritingDiagramService _diagramSrv = WritingDiagramService();

  /// The task type.
  final TestTask _testTask;

  /// Selected prompt type.
  WritingPromptType? _promptType;

  /// Generated prompt components.
  WritingPromptVo? _writingPrompt;

  /// Diagram file path.
  String _diagramPath = '';

  /// Processing state of prompt text generation.
  /// 0: not generated, 1: generating, 2: generated
  int _promptTextState = 0;

  WritingQuestionGeneratorFormController({
    required WritingApiService apiSrv,
    required TestTask testTask,
    WritingPromptVo? writingPrompt,
    List<String>? topics,
    WritingPromptType? promptType,
  }) : _topics = topics != null ? List.from(topics) : [],
       _usedTopics = topics != null ? List.from(topics) : [],
       _promptType = promptType,
       _testTask = testTask {
    _writingPrompt = writingPrompt;
    if (writingPrompt != null) {
      _promptTextState = writingPrompt.promptText.isNotEmpty ? 2 : 0;
    }
    _loadDiagram();
  }

  WritingPromptType? get promptType => _promptType;

  List<String> get topics => _topics;

  List<String> get usedTopics => _usedTopics;

  WritingPromptVo? get writingPrompt => _writingPrompt;

  String get diagramPath => _diagramPath;

  /// Whether the generate button is enabled.
  bool get isGenerateButtonEnabled => _promptType != null;

  /// Whether the start button is enabled;
  bool get isStartButtonEnabled {
    // return _writingPrompt?.promptText.isNotEmpty && isPromptTextGenerated;
    return _writingPrompt == null
        ? false
        : _writingPrompt!.promptText.isNotEmpty && isPromptTextGenerated;
  }

  /// Whether the prompt text has not been generated yet.
  bool get isPromptTextNotGenerated => _promptTextState == 0;

  /// Whether the prompt text is being generated.
  bool get isPromptTextGenerating => _promptTextState == 1;

  /// Whether the prompt text has been generated.
  bool get isPromptTextGenerated => _promptTextState == 2;

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

  /// Generates prompt text using the entered topics.
  Future<void> generatePromptText() async {
    // Update screen.
    _promptTextState = 1;
    notifyListeners();

    // Generate a topic if not entered.
    final targetTopics = topics.isEmpty
        ? [...(await _apiSrv.generateTopics(1))]
        : [...topics];

    // Generate prompt.
    if (_testTask == TestTask.writingTask1) {
      if (_diagramPath.isNotEmpty) {
        await _diagramSrv.removeTmpFiles();
      }

      final prompt = await _apiSrv.generateTask1Prompt(
        _promptType!.diagramType,
        targetTopics,
      );
      final uuid = await _diagramSrv.writeTempImage(prompt.diagramData);
      _writingPrompt = WritingPromptVo(
        taskContext: prompt.introduction,
        taskInstruction: prompt.instruction,
        diagramDescription: prompt.diagramDescription,
        diagramUuid: uuid,
      );
      _diagramPath = await _diagramSrv.getTempFilePath(uuid);
    } else {
      final prompt = await _apiSrv.generateTask2Prompt(
        _promptType!.essayType,
        targetTopics,
      );
      _writingPrompt = WritingPromptVo(
        taskContext: prompt.statement,
        taskInstruction: prompt.instruction,
      );
    }

    // Store topics to show on screen.
    _topics.clear();
    _topics.addAll(targetTopics);

    // Store topics used in generating
    _usedTopics.clear();
    _usedTopics.addAll(targetTopics);

    // Update screen.
    _promptTextState = 2;
    notifyListeners();
  }

  /// Loads and shows the diagram image.
  Future<void> _loadDiagram() async {
    if (_writingPrompt == null) {
      return;
    }
    if (_testTask == TestTask.writingTask1 &&
        _writingPrompt!.diagramUuid != null) {
      _diagramPath = await _diagramSrv.getTempFilePath(
        _writingPrompt!.diagramUuid!,
      );
    }
    notifyListeners();
  }
}
