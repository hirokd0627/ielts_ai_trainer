import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer_repository.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_diagram_service.dart';
import 'package:ielts_ai_trainer/shared/domain/score_calculation_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Controller for WritingResultScreen.
class WritingResultController extends ChangeNotifier {
  /// Repository for user answers related to writing tasks.
  final WritingAnswerRepository _repo;

  /// API service to grade the answer.
  final WritingApiService _apiSrv;

  final WritingDiagramService _diagramSrv = WritingDiagramService();

  /// The currently loaded writing answer to display and grade.
  WritingAnswer? _writingAnswer;

  /// The diagram file path.
  String _diagramPath = '';

  /// Whether the diagram image file exists.
  bool _existsDiagramFile = false;

  WritingResultController({
    required WritingAnswerRepository repo,
    required WritingApiService apiSrv,
  }) : _repo = repo,
       _apiSrv = apiSrv;

  String get diagramPath => _diagramPath;

  String get bandScore {
    if (_writingAnswer == null ||
        !_writingAnswer!.isGraded ||
        (_writingAnswer!.coherenceScore != null &&
            _writingAnswer!.lexicalScore != null &&
            _writingAnswer!.grammaticalScore != null &&
            _writingAnswer!.taskScore != null)) {
      return '-';
    }
    return ScoreCalculationService.calculateScore([
      _writingAnswer!.coherenceScore!,
      _writingAnswer!.lexicalScore!,
      _writingAnswer!.grammaticalScore!,
      _writingAnswer!.taskScore!,
    ]).toString();
  }

  String get taskScore => _writingAnswer?.taskScore.toString() ?? '';

  String get coherenceScore => _writingAnswer?.coherenceScore.toString() ?? '';

  String get grammaticalScore =>
      _writingAnswer?.grammaticalScore.toString() ?? '';

  String get lexicalScore => _writingAnswer?.lexicalScore.toString() ?? '';

  String get taskFeedback => _writingAnswer?.taskFeedback ?? "";

  String get coherenceFeedback => _writingAnswer?.coherenceFeedback ?? "";

  String get lexicalFeedback => _writingAnswer?.lexicalFeedback ?? "";

  String get grammaticalFeedback => _writingAnswer?.grammaticalFeedback ?? "";

  String get taskContext => _writingAnswer?.writingPrompt.taskContext ?? "";

  String get task2PromptText {
    if (_writingAnswer == null) {
      return '';
    }
    return "${_writingAnswer!.writingPrompt.taskContext} ${_writingAnswer!.writingPrompt.taskInstruction}";
  }

  String get taskInstruction =>
      _writingAnswer?.writingPrompt.taskInstruction ?? "";

  String get answerText => _writingAnswer?.answerText ?? "";

  bool get isGraded => _writingAnswer?.isGraded ?? false;

  bool get existsDiagramFile => _existsDiagramFile;

  /// Loads the answer by its id.
  Future<void> loadData(int id) async {
    _writingAnswer = await _repo.selectAnswerById(id);

    if (_writingAnswer!.testTask == TestTask.writingTask1) {
      _diagramPath = await _diagramSrv.getFilePath(
        _writingAnswer!.writingPrompt.diagramUuid!,
      );
      if (_writingAnswer!.writingPrompt.diagramUuid != null &&
          _writingAnswer!.writingPrompt.diagramUuid!.isNotEmpty) {
        _existsDiagramFile = await _diagramSrv.existsFile(
          _writingAnswer!.writingPrompt.diagramUuid!,
        );
      }
    }

    notifyListeners();
  }

  /// Evaluates the current answer and updates the answer in the repository,
  Future<void> evaluateAnswer() async {
    late WritingEvaluationResponse resp;
    if (_writingAnswer!.testTask == TestTask.writingTask1) {
      resp = await _apiSrv.evaluateTask1Answer(
        promptText: _writingAnswer!.writingPrompt.promptText,
        promptType: _writingAnswer!.promptType,
        diagramDescription: _writingAnswer!.writingPrompt.diagramDescription!,
        answerText: _writingAnswer!.answerText,
      );
    } else {
      resp = await _apiSrv.evaluateTask2Answer(
        promptText: _writingAnswer!.writingPrompt.promptText,
        answerText: _writingAnswer!.answerText,
      );
    }

    final gradedAnswer = _writingAnswer!.copyWith(
      taskScore: resp.taskScore,
      coherenceScore: resp.coherenceScore,
      lexicalScore: resp.lexicalScore,
      grammaticalScore: resp.grammaticalScore,
      taskFeedback: resp.taskFeedback.join(" "),
      coherenceFeedback: resp.coherenceFeedback.join(" "),
      lexicalFeedback: resp.lexicalFeedback.join(" "),
      grammaticalFeedback: resp.grammaticalFeedback.join(" "),
      isGraded: true,
    );

    try {
      _repo.saveUserAnswerWriting(gradedAnswer);
      _writingAnswer = gradedAnswer;
    } catch (e) {
      return;
    }

    notifyListeners();
  }
}
