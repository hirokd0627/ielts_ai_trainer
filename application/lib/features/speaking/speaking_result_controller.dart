import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_answer_repository.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/utterance_recording_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Controller for SpeakingResultScreen.
class SpeakingResultController extends ChangeNotifier {
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
    return _chatAnswer != null
        ? _chatAnswer!.bandScore.toString()
        : _speechAnswer?.bandScore.toString() ?? '';
  }

  String get fluencyScore {
    if (_chatAnswer != null) {
      return _chatAnswer!.fluencyScore != null
          ? _chatAnswer!.fluencyScore.toString()
          : '-';
    }
    return _speechAnswer!.fluencyScore != null
        ? _speechAnswer!.fluencyScore.toString()
        : '-';
  }

  String get coherenceScore {
    return _chatAnswer != null
        ? _chatAnswer!.coherenceScore.toString()
        : _speechAnswer?.coherenceScore.toString() ?? '';
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

  String get fluencyFeedback {
    if (_chatAnswer != null) {
      return _chatAnswer!.fluencyFeedback != null
          ? _chatAnswer!.fluencyFeedback.toString()
          : '';
    }
    return _speechAnswer!.fluencyFeedback != null
        ? _speechAnswer!.fluencyFeedback.toString()
        : '-';
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

  List<SpeakingUtteranceVO> get utterances {
    return _chatAnswer?.utterances ?? [];
  }

  bool get isPlaying => _playingState == 1;

  /// Returns an audio file UUID for the given index.
  String? _getAudioFileUuid(int index) {
    return utterances[index].audioFileUuid;
  }

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
    } else {
      // Part 1 or 3
      _chatAnswer = await _repo.selectPart13AnswerById(id);
      for (var i = 0; i < _chatAnswer!.utterances.length; i++) {
        _recordingFileExists[i] = _getAudioFileUuid(i) != null
            ? await _recordingSrv.recordingFileExists(_getAudioFileUuid(i)!)
            : false;
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
  }

  /// Starts playing the recorded chat audio for the message at the given index.
  Future<void> startPlayingChatAudio(int index) async {
    _playingState = 1;
    _currentPlayingIndex = index;

    await _recordingSrv.playAudio(_getAudioFileUuid(index)!);
    notifyListeners();
  }

  /// Starts playing the recorded speech audio for the message at the given index.
  Future<void> startPlayingSpeechAudio() async {
    _playingState = 1;
    _currentPlayingIndex = 1;

    await _recordingSrv.playAudio(_speechAnswer!.answer.audioFileUuid!);
    notifyListeners();
  }

  /// Stops playing the currently playing recorded speech.
  Future<void> stopPlaying() async {
    _playingState = 0;
    _currentPlayingIndex = -1;

    await _recordingSrv.stopAudio();
    notifyListeners();
  }

  /// Called when the play stops.
  void _onPlayerComplete() {
    _playingState = 0;
    _currentPlayingIndex = -1;

    notifyListeners();
  }

  /// Evaluates the current answer for Part 1 or Part 3 and updates the answer in the repository,
  Future<void> _evaluateChatAnswer() async {
    final resp = await _apiSrv.evaluateChatAnswer(answer: _chatAnswer!);

    // Updates results in answer
    final gradedAnswer = _chatAnswer!.copyWith(
      coherenceScore: resp.coherenceScore,
      lexicalScore: resp.lexicalScore,
      grammaticalScore: resp.grammaticalScore,
      coherenceFeedback: resp.coherenceFeedback.join(" "),
      lexicalFeedback: resp.lexicalFeedback.join(" "),
      grammaticalFeedback: resp.grammaticalFeedback.join(" "),
      isGraded: true,
      updatedAt: DateTime.now(),
      utterances: utterances,
      bandScore: resp.bandScore,
    );

    _repo.saveSpeakingChatAnswer(gradedAnswer);
    _chatAnswer = gradedAnswer;

    notifyListeners();
  }

  /// Evaluates the current answer for Part 2 and updates the answer in the repository,
  Future<void> _evaluateSpeechAnswer() async {
    final resp = await _apiSrv.evaluateSpeechAnswer(answer: _speechAnswer!);

    // Updates results in answer
    final gradedAnswer = _speechAnswer!.copyWith(
      updatedAt: DateTime.now(),
      isGraded: true,
      coherenceScore: resp.coherenceScore,
      lexicalScore: resp.lexicalScore,
      grammaticalScore: resp.grammaticalScore,
      bandScore: resp.bandScore,
      coherenceFeedback: resp.coherenceFeedback.join(" "),
      lexicalFeedback: resp.lexicalFeedback.join(" "),
      grammaticalFeedback: resp.grammaticalFeedback.join(" "),
    );
    _repo.saveSpeakingSpeechAnswer(gradedAnswer);

    _speechAnswer = gradedAnswer;

    notifyListeners();
  }
}
