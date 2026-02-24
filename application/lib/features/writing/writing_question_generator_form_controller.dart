import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_diagram_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/setting/app_settings.dart';

/// Controller for WritingQuestionGeneratorForm.
class WritingQuestionGeneratorFormController extends ChangeNotifier {
  /// API service to generate prompt text
  final WritingApiService _apiSrv = WritingApiService();

  final WritingDiagramService _diagramSrv = WritingDiagramService();

  /// The task type.
  final TestTask _testTask;

  /// Entered topic.
  String _topic;

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
    String? topic,
    WritingPromptType? promptType,
  }) : _topic = topic ?? '',
       _promptType = promptType,
       _testTask = testTask {
    _writingPrompt = writingPrompt;
    if (writingPrompt != null) {
      _promptTextState = writingPrompt.promptText.isNotEmpty ? 2 : 0;
    }
    _loadDiagram();
  }

  WritingPromptType? get promptType => _promptType;

  String get topic => _topic;

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

  /// Sets the topic.
  set topic(String value) {
    _topic = value;
    notifyListeners();
  }

  /// Generates prompt text using the entered topics.
  Future<void> generatePromptText() async {
    // Update screen.
    _promptTextState = 1;
    notifyListeners();

    // Generate a topic if not entered.
    final targetTopic = topic.isEmpty
        ? (await _apiSrv.generateTopics(1, AppSettings.instance.aiAgent))[0]
        : topic;
    // Store topics to show on screen.
    _topic = targetTopic;

    // Generate prompt.
    if (_testTask == TestTask.writingTask1) {
      if (_diagramPath.isNotEmpty) {
        await _diagramSrv.removeTmpFiles();
      }

      final prompt = await _apiSrv.generateTask1Prompt(
        _promptType!.diagramType,
        _topic,
        AppSettings.instance.aiAgent,
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
        _topic,
        AppSettings.instance.aiAgent,
      );
      _writingPrompt = WritingPromptVo(
        taskContext: prompt.statement,
        taskInstruction: prompt.instruction,
      );
    }

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
