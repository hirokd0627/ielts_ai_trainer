import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer_repository.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_diagram_service.dart';

/// Controller for WritingResultScreen.
class WritingResultController extends ChangeNotifier {
  /// Repository for user answers related to writing tasks.
  final WritingAnswerRepository _repo;

  /// API service to grade the answer.
  final WritingApiService _apiSrv;

  final WritingDiagramService _diagramSrv = WritingDiagramService();

  /// The currently loaded writing answer to display and grade.
  WritingAnswer? _writingAnswer;

  String _diagramPath = '';

  WritingResultController({
    required WritingAnswerRepository repo,
    required WritingApiService apiSrv,
  }) : _repo = repo,
       _apiSrv = apiSrv;

  String get diagramPath => _diagramPath;

  String get bandScore => _writingAnswer?.bandScore.toString() ?? "";

  String get taskScore => _writingAnswer?.taskScore.toString() ?? '';

  String get coherenceScore => _writingAnswer?.coherenceScore.toString() ?? '';

  String get grammaticalScore =>
      _writingAnswer?.grammaticalScore.toString() ?? '';

  String get lexialScore => _writingAnswer?.lexialScore.toString() ?? '';

  String get taskFeedback => _writingAnswer?.taskFeedback ?? "";
  String get coherenceFeedback => _writingAnswer?.coherenceFeedback ?? "";
  String get lexialFeedback => _writingAnswer?.lexialFeedback ?? "";
  String get grammaticalFeedback => _writingAnswer?.grammaticalFeedback ?? "";

  String get taskContext => _writingAnswer?.writingPrompt.taskContext ?? "";

  String get taskInstruction =>
      _writingAnswer?.writingPrompt.taskInstruction ?? "";

  String get answerText => _writingAnswer?.answerText ?? "";

  bool get isGraded => _writingAnswer?.isGraded ?? false;

  /// Loads the answer by its id.
  Future<void> loadData(int id) async {
    _writingAnswer = await _repo.selectAnswerById(id);

    _diagramPath = await _diagramSrv.getTempFilePath(
      _writingAnswer!.writingPrompt.diagramUuid!,
    );
    notifyListeners();
  }

  /// Evaluates the current answer and updates the answer in the repository,
  Future<void> evaluateAnswer() async {
    final resp = await _apiSrv.evaluateTask1Answer(
      promptText: _writingAnswer!.writingPrompt.promptText,
      promptType: _writingAnswer!.promptType,
      diagramDescription: _writingAnswer!.writingPrompt.diagramDescription!,
      answerText: _writingAnswer!.answerText,
    );

    // Updates results in answer
    // final gradedAnswer = _writingAnswer!.copyWith(
    //   achievement: resp.achievement,
    //   coherence: resp.coherence,
    //   lexial: resp.lexial,
    //   grammatical: resp.grammatical,
    //   score: resp.score,
    //   feedback: resp.feedback,
    //   isGraded: true,
    //   updatedAt: DateTime.now(),
    // );
    final gradedAnswer = _writingAnswer!.copyWith(
      taskScore: resp.taskScore,
      coherenceScore: resp.taskScore,
      lexialScore: resp.taskScore,
      grammaticalScore: resp.taskScore,
      taskFeedback: resp.taskFeedback.join(" "),
      coherenceFeedback: resp.coherenceFeedback.join(" "),
      lexialFeedback: resp.lexicalFeedback.join(" "),
      grammaticalFeedback: resp.grammaticalFeedback.join(" "),
      isGraded: true,
      updatedAt: DateTime.now(),
    );

    // _repo.saveUserAnswerWriting(_writingAnswer!);
    _repo.saveUserAnswerWriting(gradedAnswer);

    _writingAnswer = gradedAnswer;

    notifyListeners();
  }
}
