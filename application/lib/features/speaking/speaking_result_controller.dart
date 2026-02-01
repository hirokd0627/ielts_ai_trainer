import 'package:collection/collection.dart';
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

  String get overallScore {
    return _chatAnswer != null
        ? _chatAnswer!.score.toString()
        : _speechAnswer?.score.toString() ?? '';
  }

  String get fluencyScore {
    return _chatAnswer != null
        ? _chatAnswer!.fluency.toString()
        : _speechAnswer?.fluency.toString() ?? '';
  }

  String get coherenceScore {
    return _chatAnswer != null
        ? _chatAnswer!.coherence.toString()
        : _speechAnswer?.coherence.toString() ?? '';
  }

  String get grammaticalScore {
    return _chatAnswer != null
        ? _chatAnswer!.grammatical.toString()
        : _speechAnswer?.grammatical.toString() ?? '';
  }

  String get lexialScore {
    return _chatAnswer != null
        ? _chatAnswer!.lexial.toString()
        : _speechAnswer?.lexial.toString() ?? '';
  }

  String get feedbackText {
    return _chatAnswer != null
        ? _chatAnswer!.feedback.toString()
        : _speechAnswer?.feedback.toString() ?? '';
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

  /// Grades the current answer and updates the answer in the repository,
  Future<void> grade() async {
    if (_testTask == TestTask.speakingPart2) {
      await _gradeSpeechAnswer();
    } else {
      await _gradeChatAnswer();
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

  /// Grades the current answer for Part 1 or Part 3 and updates the answer in the repository,
  Future<void> _gradeChatAnswer() async {
    final resp = await _apiSrv.gradeChatAnswer(answer: _chatAnswer!);

    final utterances = _chatAnswer!.utterances.mapIndexed((i, u) {
      return u.copyWith(fluency: resp.utteranceFluency[i]);
    }).toList();

    // Updates results in answer
    final gradedAnswer = _chatAnswer!.copyWith(
      fluency: resp.fluency,
      coherence: resp.coherence,
      lexial: resp.lexial,
      grammatical: resp.grammatical,
      score: resp.score,
      feedback: resp.feedback,
      isGraded: true,
      updatedAt: DateTime.now(),
      utterances: utterances,
    );
    _repo.saveSpeakingChatAnswer(gradedAnswer);

    _chatAnswer = gradedAnswer;

    notifyListeners();
  }

  /// Grades the current answer for Part 2 and updates the answer in the repository,
  Future<void> _gradeSpeechAnswer() async {
    final resp = await _apiSrv.gradeSpeechAnswer(answer: _speechAnswer!);

    // Updates results in answer
    final gradedAnswer = _speechAnswer!.copyWith(
      fluency: resp.fluency,
      coherence: resp.coherence,
      lexial: resp.lexial,
      grammatical: resp.grammatical,
      score: resp.score,
      feedback: resp.feedback,
      isGraded: true,
      updatedAt: DateTime.now(),
      answer: _speechAnswer!.answer.copyWith(fluency: resp.fluency),
    );
    _repo.saveSpeakingSpeechAnswer(gradedAnswer);

    _speechAnswer = gradedAnswer;

    notifyListeners();
  }
}
