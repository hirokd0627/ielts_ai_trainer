import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_answer_repository.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_id_vo.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/utterance_recording_service.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Controller for SpeakingChatInputView.
class SpeakingChatInputController extends ChangeNotifier {
  /// Repository for user answers related to speaking tasks.
  final SpeakingAnswerRepository _repo;

  /// The start time used to calculate the elapsed duration.
  late DateTime _startTime;

  /// Timer used to track the elapsed duration.
  late Timer _timer;

  /// Elapsed time since the timer started.
  Duration _elapsed = const Duration();

  /// The minimum number of messages required to enable submission.
  static const int _minSubmitMessageCount = 3;

  /// API service to generate reply messages.
  final SpeakingApiService _apiSrv = SpeakingApiService();

  /// The list of messages exhanged between the user and AI.
  final List<SpeakingUtteranceVO> _messages = [];

  /// The topics used to generate the prompt.
  final List<String> _topics;

  /// The task type.
  final TestTask _testTask;

  /// The service to record the user's speech.
  late final UtteranceRecordingService _recordingSrv;

  /// The index of messages currently being recorded.
  int _currentRecordingIndex = -1;

  /// The index of messages currently being played.
  int _currentPlayingIndex = -1;

  /// The current message text that the user entered.
  String _currentMessageText = '';

  /// Whether prompt text is being generated.
  bool _isGeneratingPromptText = false;

  /// The map _messages index to temporary UUID of teh recorded audio file.
  final Map<int, String> _recordingFileUuidMap = {};

  /// The map _messages index to recording state: 0 = not started, 1 = recording, 2 = recorded, 3 = rerecording.
  final Map<int, int> _recordingState = {};

  SpeakingChatInputController({
    required SpeakingAnswerRepository speakingAnswerRepository,
    required String promptText,
    required List<String> topics,
    required TestTask testTask,
  }) : _repo = speakingAnswerRepository,
       _topics = topics,
       _testTask = testTask {
    _recordingSrv = UtteranceRecordingService(
      onPlayerComplete: _onPlayerComplete,
    );
  }

  Duration get elapsed => _elapsed;

  /// Returns the elapsed duration since the timer started.
  Duration get _elapsedDuration {
    final msec =
        DateTime.now().millisecondsSinceEpoch -
        _startTime.millisecondsSinceEpoch;
    return Duration(milliseconds: msec);
  }

  /// Returns the elapsed time for display.
  String get elapsedAsText {
    final elapsed = _elapsed;
    final m = elapsed.inMinutes.toString().padLeft(2, '0');
    final s = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return "Time: $m:$s";
  }

  List<SpeakingUtteranceVO> get messages => _messages;

  int get _userMessageCount => _messages.where((e) => e.isUser).toList().length;

  bool get isSubmitButtonEnabled => _userMessageCount >= _minSubmitMessageCount;

  /// Returns the remaining count to submit the answer.
  int get replyCountUntilSubmitEnabled =>
      _minSubmitMessageCount - _userMessageCount;

  bool get isMessageInputEnabled => _currentMessageText.isNotEmpty;

  bool get isRecording =>
      _recordingState.containsValue(1) || _recordingState.containsValue(3);

  bool get isPlaying => _currentPlayingIndex != -1;

  /// Returns if allowing the user to use controls.
  /// Disables controls if recording speech, playing audio, or generating replies.
  bool get isControlsEnabled =>
      !isRecording && !isPlaying && !_isGeneratingPromptText;

  String get currentMessageText => _currentMessageText;

  set currentMessageText(String value) {
    _currentMessageText = value;

    notifyListeners();
  }

  bool isRecordingAt(int index) => _recordingState[index] == 1;

  bool isRecordedAt(int index) => _recordingState[index] == 2;

  bool isReRecordingAt(int index) => _recordingState[index] == 3;

  bool isPlayingAt(int index) => _currentPlayingIndex == index;

  bool isRecordingButtonEnabledAt(int index) {
    if (isPlaying) {
      return false;
    }
    if (_currentRecordingIndex == -1 ||
        _currentRecordingIndex ==
            index // allows to stop
            ) {
      return true;
    }
    return false;
  }

  bool isPlayButtonEnabledAt(int index) {
    if (isRecording) {
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

  bool isShowPlayButtonAt(int index) {
    // show after recorded
    return isRecordedAt(index) || isReRecordingAt(index);
  }

  String getRecordingButtonLabelAt(int index) {
    return isRecordingAt(index) || isReRecordingAt(index)
        ? 'Stop'
        : 'Recording';
  }

  String getPlayButtonLabelAt(int index) {
    return isPlayingAt(index) ? 'Stop' : 'Play';
  }

  void _setIsGeneratingPromptText(bool value) {
    _isGeneratingPromptText = value;
    notifyListeners();
  }

  /// Starts the duration timer.
  void startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed = _elapsedDuration;

      notifyListeners();
    });
  }

  /// Stops the duration timer.
  void cancelTimer() {
    _timer.cancel();
  }

  /// Adds a message to the message list.
  void addMessage(bool isUser, String text) {
    final nextOrder = _messages.length + 1;
    _messages.add(
      SpeakingUtteranceVO(order: nextOrder, isUser: isUser, text: text),
    );

    _recordingState[_messages.length - 1] = 0;

    notifyListeners();
  }

  /// Generates a reply.
  Future<void> generateNextPrompt(String reply) async {
    _setIsGeneratingPromptText(true);

    try {
      final resp = await _apiSrv.generateChatReply(reply);
      addMessage(false, resp.message);
      _recordingState[_messages.length - 1] = 0;
    } finally {
      _setIsGeneratingPromptText(false);
      notifyListeners();
    }
  }

  /// Saves the user's answer.
  Future<int> saveUserAnswer() async {
    final now = DateTime.now();

    final topics = <PromptTopic>[];
    for (var i = 0; i < _topics.length; i++) {
      topics.add(PromptTopic(order: (i + 1), title: _topics[i]));
    }

    final answer = SpeakingChatAnswer(
      utterances: _messages,
      createdAt: now,
      updatedAt: now,
      topics: topics,
      isGraded: false,
      duration: _elapsedDuration.inSeconds,
      testTask: _testTask,
    );

    final ids = await _repo.saveSpeakingChatAnswer(answer);

    // Persists the temporary recording file.
    try {
      _persistRecordingFile(ids.utteranceIds);
    } catch (e, stackTrace) {
      await _repo.deleteSpeakingUserAnswer(ids.id); // rollback
      throw Exception('Failed to persist recording file: $e\n$stackTrace');
    }

    return ids.id;
  }

  /// Deletes all the temporary recording files.
  Future<void> deleteAllTemporaryRecordingFiles() async {
    _recordingFileUuidMap.forEach((i, uuid) async {
      await _deleteTemporaryRecordingFile(i);
    });
  }

  /// Starts recording the user's speech in the message at the given index.
  Future<void> startRecording(int index) async {
    await _deleteTemporaryRecordingFile(index); // deletes old temporary file

    _currentRecordingIndex = index;

    _recordingFileUuidMap[index] = await _recordingSrv.startRecording();

    _recordingState[_currentRecordingIndex] =
        (_recordingState[_currentRecordingIndex] == 2) ? 3 : 1;

    notifyListeners();
  }

  /// Stops the curently recording.
  Future<void> stopRecording() async {
    if (isRecording) {
      await _recordingSrv.stopRecording();
      _recordingState[_currentRecordingIndex] = 2; // recorded

      // Updates audio file UUID
      _messages[_currentRecordingIndex] = _messages[_currentRecordingIndex]
          .copyWith(
            audioFileUuid: _recordingFileUuidMap[_currentRecordingIndex],
          );
    }
    _currentRecordingIndex = -1;

    notifyListeners();
  }

  /// Starts playing the recorded speech for the message at the given index.
  Future<void> startPlaying(int index) async {
    _currentPlayingIndex = index;

    await _recordingSrv.playAudio(
      _recordingFileUuidMap[index]!,
      temporaryfile: true,
    );
    notifyListeners();
  }

  /// Stops playing the currently playing recorded speech.
  Future<void> stopPlaying() async {
    _currentPlayingIndex = -1;

    await _recordingSrv.stopAudio();
    notifyListeners();
  }

  /// Called when the play stops.
  void _onPlayerComplete() {
    _currentPlayingIndex = -1;

    notifyListeners();
  }

  /// Persists the temporary recording files and deletes them.
  Future<void> _persistRecordingFile(
    List<SpeakingUtteranceIdVO> utteranceIds,
  ) async {
    _recordingFileUuidMap.forEach((_, uuid) async {
      await _recordingSrv.persistRecordingFile(uuid);
    });
  }

  /// Deletes the temporary recording file at the given index.
  Future<void> _deleteTemporaryRecordingFile(int index) async {
    if (_recordingFileUuidMap[index]?.isNotEmpty ?? false) {
      await _recordingSrv.deleteTemporaryRecordingFile(
        _recordingFileUuidMap[index]!,
      );
      _recordingFileUuidMap.remove(index);
    }
  }
}
