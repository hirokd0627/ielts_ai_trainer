import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer_repository.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';

/// Controller for WritingResultScreen.
class WritingResultController extends ChangeNotifier {
  /// Repository for user answers related to writing tasks.
  final WritingAnswerRepository _repo;

  /// API service to grade the answer.
  final WritingApiService _apiSrv;

  /// The currently loaded writing answer to display and grade.
  WritingAnswer? _writingAnswer;

  WritingResultController({
    required WritingAnswerRepository repo,
    required WritingApiService apiSrv,
  }) : _repo = repo,
       _apiSrv = apiSrv;

  String get overallScore {
    return _writingAnswer?.score.toString() ?? "";
  }

  String get achievementScore {
    return _writingAnswer?.achievement.toString() ?? '';
  }

  String get coherenceScore {
    return _writingAnswer?.coherence.toString() ?? '';
  }

  String get grammaticalScore {
    return _writingAnswer?.grammatical.toString() ?? '';
  }

  String get lexialScore {
    return _writingAnswer?.lexial.toString() ?? '';
  }

  String get feedbackText {
    return _writingAnswer?.feedback ?? "";
  }

  String get promptText {
    return _writingAnswer?.promptText ?? "";
  }

  String get answerText {
    return _writingAnswer?.answerText ?? "";
  }

  bool get isGraded {
    return _writingAnswer?.isGraded ?? false;
  }

  /// Loads the answer by its id.
  Future<void> loadData(int id) async {
    _writingAnswer = await _repo.selectAnswerById(id);

    notifyListeners();
  }

  /// Grades the current answer and updates the answer in the repository,
  Future<void> grade() async {
    final resp = await _apiSrv.gradeAnswer(
      testTask: _writingAnswer!.testTask,
      promptType: _writingAnswer!.promptType,
      promptText: _writingAnswer!.promptText,
      answerText: _writingAnswer!.answerText,
    );

    // Updates results in answer
    final gradedAnswer = _writingAnswer!.copyWith(
      achievement: resp.achievement,
      coherence: resp.coherence,
      lexial: resp.lexial,
      grammatical: resp.grammatical,
      score: resp.score,
      feedback: resp.feedback,
      isGraded: true,
      updatedAt: DateTime.now(),
    );
    _repo.saveUserAnswerWriting(gradedAnswer);

    _writingAnswer = gradedAnswer;

    notifyListeners();
  }
}
