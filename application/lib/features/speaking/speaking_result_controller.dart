import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_answer_repository.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/utterance_recording_service.dart';
import 'package:ielts_ai_trainer/shared/domain/score_calculation_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/setting/app_settings.dart';
import 'package:ielts_ai_trainer/shared/views/controller_exception.dart';

/// Controller for SpeakingResultScreen.
class SpeakingResultController extends ChangeNotifier {
  final _logger = createLogger('SpeakingResultController');

  /// Repository for user answers related to speaking parts.
  final SpeakingAnswerRepository _repo;

  /// API service to grade the answer.
  final SpeakingApiService _apiSrv;

  /// The task type.
  final TestTask _testTask;

  /// The currently loaded speaking chat answer to display and grade.
  SpeakingChatAnswer? _chatAnswer;

  /// The currently loaded speaking speech answer to display and grade.
  SpeakingSpeechAnswer? _speechAnswer;

  /// The index of messages currently being played.
  int _currentPlayingIndex = -1;

  /// The service to record the user's speech.
  late final UtteranceRecordingService _recordingSrv;

  /// The playing state: 0 = stop, 1 = playing.
  int _playingState = 0;

  /// Whether a recording file exists for each index.
  final Map<int, bool> _recordingFileExists = {};

  /// Whether the utterance at each index has been graded.
  final Map<int, bool> _isUtteranceGraded = {};

  /// Whether the evaluation has been failed.
  bool _isEvaluationFailed = false;

  /// Whether the evaluation of each utterance has been failed
  final Map<int, bool> _isUtteranceEvaluationFailed = {};

  SpeakingResultController({
    required SpeakingAnswerRepository repo,
    required SpeakingApiService apiSrv,
    required TestTask testTask,
  }) : _repo = repo,
       _apiSrv = apiSrv,
       _testTask = testTask {
    _recordingSrv = UtteranceRecordingService(
      onPlayerComplete: _onPlayerComplete,
    );
  }

  String get bandScore {
    if (_chatAnswer != null) {
      if (!_chatAnswer!.isGraded ||
          _chatAnswer!.coherenceScore == null ||
          _chatAnswer!.lexicalScore == null ||
          _chatAnswer!.grammaticalScore == null) {
        return '-';
      }
      final scores = [
        _chatAnswer!.lexicalScore!,
        _chatAnswer!.grammaticalScore!,
      ];
      if (_chatAnswer!.isEvaluatedPronunciation) {
        scores.add(
          ScoreCalculationService.calculateScore([
            _chatAnswer!.coherenceScore!,
            _chatAnswer!.fluencyScore,
          ]),
        );
        scores.add(_chatAnswer!.pronunciationScore);
      } else {
        scores.add(_chatAnswer!.coherenceScore!);
      }
      return ScoreCalculationService.calculateScore(scores).toString();
    }

    if (_speechAnswer != null) {
      if (!_speechAnswer!.isGraded ||
          _speechAnswer!.coherenceScore == null ||
          _speechAnswer!.lexicalScore == null ||
          _speechAnswer!.grammaticalScore == null) {
        return '-';
      }
      final scores = [
        _speechAnswer!.lexicalScore!,
        _speechAnswer!.grammaticalScore!,
      ];
      if (_speechAnswer!.isEvaluatedPronunciation) {
        scores.add(
          ScoreCalculationService.calculateScore([
            _speechAnswer!.coherenceScore!,
            _speechAnswer!.fluencyScore,
          ]),
        );
        scores.add(_speechAnswer!.pronunciationScore);
      } else {
        scores.add(_speechAnswer!.coherenceScore!);
      }
      return ScoreCalculationService.calculateScore(scores).toString();
    }

    return '-';
  }

  String get pronunciationScore {
    if (_chatAnswer != null && _chatAnswer!.isEvaluatedPronunciation) {
      return _chatAnswer!.pronunciationScore.toString();
    }
    if (_speechAnswer != null && _speechAnswer!.isEvaluatedPronunciation) {
      return _speechAnswer!.pronunciationScore.toString();
    }
    return '-';
  }

  bool get isEvaluatedPronunciation {
    if (_chatAnswer != null) {
      return _chatAnswer!.isEvaluatedPronunciation;
    }
    if (_speechAnswer != null) {
      return _speechAnswer!.isEvaluatedPronunciation;
    }
    return false;
  }

  /// Returns Coherence and Fluency scores if audio is recorded and evaluated,
  /// otherwise, returns only Coherence score.
  String get coherenceScore {
    if (_chatAnswer != null) {
      if (_chatAnswer!.isEvaluatedPronunciation) {
        return _chatAnswer!.fluencyAndCoherenceScore.toString();
      } else {
        return _chatAnswer!.coherenceScore!.toString();
      }
    }
    if (_speechAnswer != null) {
      if (_speechAnswer!.isEvaluatedPronunciation) {
        return _speechAnswer!.fluencyAndCoherenceScore.toString();
      } else {
        return _speechAnswer!.coherenceScore!.toString();
      }
    }
    return '-';
  }

  String get grammaticalScore {
    return _chatAnswer != null
        ? _chatAnswer!.grammaticalScore.toString()
        : _speechAnswer?.grammaticalScore.toString() ?? '';
  }

  String get lexicalScore {
    return _chatAnswer != null
        ? _chatAnswer!.lexicalScore.toString()
        : _speechAnswer?.lexicalScore.toString() ?? '';
  }

  String get coherenceFeedback {
    return _chatAnswer != null
        ? _chatAnswer!.coherenceFeedback != null
              ? _chatAnswer!.coherenceFeedback.toString()
              : '-'
        : _speechAnswer?.coherenceFeedback.toString() ?? '-';
  }

  String get lexicalFeedback {
    return _chatAnswer != null
        ? _chatAnswer!.lexicalFeedback != null
              ? _chatAnswer!.lexicalFeedback.toString()
              : ''
        : _speechAnswer?.lexicalFeedback.toString() ?? '-';
  }

  String get grammaticalFeedback {
    return _chatAnswer != null
        ? _chatAnswer!.grammaticalFeedback != null
              ? _chatAnswer!.grammaticalFeedback.toString()
              : ''
        : _speechAnswer?.grammaticalFeedback.toString() ?? '-';
  }

  String get promptText {
    return _speechAnswer?.prompt.text ?? "";
  }

  String get note {
    return _speechAnswer?.note ?? "";
  }

  String get answerText {
    return _speechAnswer?.answer.text ?? "";
  }

  bool get isGraded {
    return _chatAnswer != null
        ? _chatAnswer!.isGraded
        : _speechAnswer?.isGraded ?? false;
  }

  bool get isEvaluationFailed => _isEvaluationFailed;

  List<SpeakingUtteranceVO> get utterances {
    if (_chatAnswer != null) {
      return _chatAnswer!.utterances;
    }
    if (_speechAnswer != null) {
      return [_speechAnswer!.prompt, _speechAnswer!.answer];
    }
    return [];
  }

  SpeakingUtteranceVO get speechUtterance => _speechAnswer!.answer;

  bool get isPlaying => _playingState == 1;

  bool isUtteranceGraded(int index) => _isUtteranceGraded[index] ?? false;

  bool get existsUtteranceEvaluationFailed {
    return _isUtteranceEvaluationFailed.containsValue(true);
  }

  bool isUtteranceEvaluationFailed(int index) =>
      _isUtteranceEvaluationFailed[index] ?? false;

  bool isPlayingAt(int index) => _currentPlayingIndex == index;

  bool isRecorded(int index) {
    return _recordingFileExists.isNotEmpty &&
        _recordingFileExists.containsKey(index) &&
        _recordingFileExists[index]!;
  }

  bool isPlayButtonEnabledAt(int index) {
    if (!isRecorded(index)) {
      return false;
    }
    if (_currentPlayingIndex == -1 ||
        _currentPlayingIndex ==
            index // allows to stop
            ) {
      return true;
    }
    return false;
  }

  String getPlayButtonLabelAt(int index) {
    if (!isRecorded(index)) {
      return 'Not Recorded';
    }
    return isPlayingAt(index) ? 'Stop' : 'Play';
  }

  /// Loads the answer by its id.
  Future<void> loadData(int id) async {
    if (_testTask == TestTask.speakingPart2) {
      // Part 2
      _speechAnswer = await _repo.selectPart2AnswerById(id);
      _recordingFileExists[1] = _speechAnswer!.answer.audioFileUuid != null
          ? await _recordingSrv.recordingFileExists(
              _speechAnswer!.answer.audioFileUuid!,
            )
          : false;
      _isUtteranceGraded[1] = _speechAnswer!.answer.isGraded;
    } else {
      // Part 1 or 3
      _chatAnswer = await _repo.selectPart13AnswerById(id);
      for (var i = 0; i < _chatAnswer!.utterances.length; i++) {
        _recordingFileExists[i] = _getAudioFileUuid(i) != null
            ? await _recordingSrv.recordingFileExists(_getAudioFileUuid(i)!)
            : false;
        _isUtteranceGraded[i] = _chatAnswer!.utterances[i].isGraded;
      }
    }

    notifyListeners();
  }

  /// Evaluates the current answer and updates the answer in the repository,
  Future<void> evaluateAnswer() async {
    if (_testTask == TestTask.speakingPart2) {
      await _evaluateSpeechAnswer();
    } else {
      await _evaluateChatAnswer();
    }
    notifyListeners();

    if (_isEvaluationFailed || existsUtteranceEvaluationFailed) {
      throw ControllerException('evaluation error');
    }
  }

  /// Starts playing the recorded chat audio for the message at the given index.
  Future<void> startPlayingChatAudio(int index) async {
    _playingState = 1;
    _currentPlayingIndex = index;

    try {
      await _recordingSrv.playAudio(_getAudioFileUuid(index)!);
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _playingState = 0;
      _currentPlayingIndex = -1;
      throw ControllerException('playback error');
    } finally {
      notifyListeners();
    }
  }

  /// Starts playing the recorded speech audio for the message at the given index.
  Future<void> startPlayingSpeechAudio() async {
    _playingState = 1;
    _currentPlayingIndex = 1;

    try {
      await _recordingSrv.playAudio(_speechAnswer!.answer.audioFileUuid!);
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _playingState = 0;
      _currentPlayingIndex = -1;
      throw ControllerException('playback error');
    } finally {
      notifyListeners();
    }
  }

  /// Stops playing the currently playing recorded speech.
  Future<void> stopPlaying() async {
    _playingState = 0;
    _currentPlayingIndex = -1;

    try {
      await _recordingSrv.stopAudio();
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
    }

    notifyListeners();
  }

  /// Returns an audio file UUID for the given index.
  String? _getAudioFileUuid(int index) {
    return utterances[index].audioFileUuid;
  }

  /// Called when the play stops.
  void _onPlayerComplete() {
    _playingState = 0;
    _currentPlayingIndex = -1;

    notifyListeners();
  }

  /// Evaluates the current answer for Part 1 or Part 3 and updates the answer in the repository,
  Future<void> _evaluateChatAnswer() async {
    try {
      // Evaluates script.
      final resp = await _apiSrv.evaluateChatAnswer(
        answer: _chatAnswer!,
        aiName: AppSettings.instance.aiAgent,
      );

      // Updates results in answer
      if (!_chatAnswer!.isGraded) {
        final gradedAnswer = _chatAnswer!.copyWith(
          coherenceScore: resp.coherenceScore,
          lexicalScore: resp.lexicalScore,
          grammaticalScore: resp.grammaticalScore,
          coherenceFeedback: resp.coherenceFeedback.join(" "),
          lexicalFeedback: resp.lexicalFeedback.join(" "),
          grammaticalFeedback: resp.grammaticalFeedback.join(" "),
          isGraded: true,
        );

        _repo.saveSpeakingChatAnswer(gradedAnswer);
        _chatAnswer = gradedAnswer;
      }
      _isEvaluationFailed = false;
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _isEvaluationFailed = true;
    }

    // Evaluates pronunciation.
    for (int i = 0; i < _chatAnswer!.utterances.length; i++) {
      // Updates each Utterance data in _evaluatePronunciation.
      _evaluatePronunciation(i, _chatAnswer!.id!, _chatAnswer!.utterances[i]);
    }

    notifyListeners();
  }

  /// Evaluates the current answer for Part 2 and updates the answer in the repository,
  Future<void> _evaluateSpeechAnswer() async {
    try {
      final resp = await _apiSrv.evaluateSpeechAnswer(
        answer: _speechAnswer!,
        aiName: AppSettings.instance.aiAgent,
      );

      // Updates results in answer
      if (!_speechAnswer!.isGraded) {
        final gradedAnswer = _speechAnswer!.copyWith(
          coherenceScore: resp.coherenceScore,
          lexicalScore: resp.lexicalScore,
          grammaticalScore: resp.grammaticalScore,
          coherenceFeedback: resp.coherenceFeedback.join(" "),
          lexicalFeedback: resp.lexicalFeedback.join(" "),
          grammaticalFeedback: resp.grammaticalFeedback.join(" "),
          isGraded: true,
        );
        _repo.saveSpeakingSpeechAnswer(gradedAnswer);
        _speechAnswer = gradedAnswer;
      }
      _isEvaluationFailed = false;
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _isEvaluationFailed = true;
    }

    _evaluatePronunciation(1, _speechAnswer!.id!, _speechAnswer!.answer);

    notifyListeners();
  }

  /// Evaluates pronunciation of utterance.
  Future<void> _evaluatePronunciation(
    int index,
    int userAnswerId,
    SpeakingUtteranceVO utterance,
  ) async {
    if (!utterance.isUser ||
        utterance.audioFileUuid == null ||
        utterance.isGraded) {
      return;
    }

    final exists = await _recordingSrv.recordingFileExists(
      utterance.audioFileUuid!,
    );
    if (!exists) {
      return;
    }

    try {
      final audioFilePath = await _recordingSrv.getFilePath(
        utterance.audioFileUuid!,
      );
      final resp = await _apiSrv.evaluatePronunciation(
        lang: AppSettings.instance.lang.langArgmentValue,
        audioFilePath: audioFilePath,
        script: utterance.text,
      );

      // Saves results in utterance
      final graded = utterance.copyWith(
        pronunciationScore: resp.pronunciationScore,
        fluencyScore: resp.fluencyScore,
        isGraded: true,
      );
      await _repo.saveUtterance(userAnswerId, graded);

      // Updates screen.
      if (_testTask == TestTask.speakingPart2) {
        _speechAnswer = _speechAnswer!.copyWith(answer: graded);
      } else {
        final utterances = List<SpeakingUtteranceVO>.from(
          _chatAnswer!.utterances,
        );
        utterances[index] = graded;
        _chatAnswer = _chatAnswer!.copyWith(utterances: utterances);
      }

      _isUtteranceGraded[index] = true;
      _isUtteranceEvaluationFailed[index] = false;
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _isUtteranceEvaluationFailed[index] = true;
    }
    notifyListeners();
  }
}
