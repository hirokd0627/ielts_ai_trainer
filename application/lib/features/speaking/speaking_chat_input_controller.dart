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
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/setting/app_settings.dart';
import 'package:ielts_ai_trainer/shared/views/controller_exception.dart';

/// Controller for SpeakingChatInputView.
class SpeakingChatInputController extends ChangeNotifier {
  final _logger = createLogger('SpeakingChatInputController');

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

  /// The map _messages index to the UUID of recorded file.
  final Map<int, String> _recordingFileUuidMap = {};

  /// The map _messages index to recording state: 0 = not started, 1 = recording, 2 = recorded, 3 = rerecording.
  final Map<int, int> _recordingState = {};

  /// Whether conversation has ended.
  bool _isChatEnded = false;

  /// ID of most recent interaction.
  String _currentInteractionId = '';

  /// Number of replies required to advance to next topic.
  int _currentReplyCount = 0;

  /// Required reply count to move to next topic.
  static const int _requiredReplyCount = 3;

  /// Index of current topic in topic list.
  int _currentTopicIndex = 0;

  SpeakingChatInputController({
    required SpeakingAnswerRepository speakingAnswerRepository,
    required String promptText,
    required List<String> topics,
    required TestTask testTask,
    required String initialInteractionId,
  }) : _repo = speakingAnswerRepository,
       _topics = topics,
       _testTask = testTask,
       _currentInteractionId = initialInteractionId {
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

  bool get isReplyTextFieldEnabled => !_isChatEnded;

  bool get isSubmitButtonEnabled => _userMessageCount >= _minSubmitMessageCount;

  /// Returns the remaining count to submit the answer.
  int get replyCountUntilSubmitEnabled =>
      _minSubmitMessageCount - _userMessageCount;

  bool get isMessageInputEnabled =>
      _currentMessageText.isNotEmpty && !_isChatEnded;

  bool get isRecording =>
      _recordingState.containsValue(1) || _recordingState.containsValue(3);

  bool get isPlaying => _currentPlayingIndex != -1;

  /// Returns if allowing the user to use controls.
  /// Disables controls if recording speech, playing audio, or generating replies.
  bool get isControlsEnabled =>
      !isRecording && !isPlaying && !_isGeneratingPromptText;

  String get currentMessageText => _currentMessageText;

  bool get isChatEnded => _isChatEnded;

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
      SpeakingUtteranceVO(
        order: nextOrder,
        isUser: isUser,
        isGraded: false,
        text: text,
      ),
    );

    _recordingState[_messages.length - 1] = 0;

    notifyListeners();
  }

  /// Generates a reply.
  Future<void> generateQuestion(String reply) async {
    _setIsGeneratingPromptText(true);

    try {
      _currentReplyCount += 1;

      final changeTopic = _currentReplyCount >= _requiredReplyCount;
      if (changeTopic) {
        _currentTopicIndex += 1;

        if (_currentTopicIndex >= _topics.length) {
          // Completed all questions.
          // Add closing message.
          final msg = await _apiSrv.generateClosingMessage(_testTask);
          addMessage(false, msg);
          notifyListeners();

          _isChatEnded = true;
        } else {
          // Move to next topic.
          // Add transition message.
          final transition = await _apiSrv.generateTopicTransitionMessage(
            _topics[_currentTopicIndex],
          );
          addMessage(false, transition);
          notifyListeners();

          // Add question.
          final resp = await _apiSrv.generateInitialQuestion(
            _testTask.number,
            _topics[_currentTopicIndex],
            AppSettings.instance.aiAgent,
          );
          addMessage(false, resp.question);
          _recordingState[_messages.length - 1] = 0;

          _currentInteractionId = resp.interactionId;
          _currentReplyCount = 0;
        }
      } else {
        // Ask subsequent question.
        // Add question.
        final resp = await _apiSrv.generateSubsequentQuestion(
          _testTask.number,
          _currentInteractionId,
          reply,
          AppSettings.instance.aiAgent,
        );
        addMessage(false, resp.question);
        _recordingState[_messages.length - 1] = 0;

        _currentInteractionId = resp.interactionId;
      }
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      throw ControllerException(
        'question generation error',
        exception: e,
        stackTrace: s,
      );
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
      topics: topics,
      isGraded: false,
      duration: _elapsedDuration.inSeconds,
      testTask: _testTask,
    );

    late ({int id, List<SpeakingUtteranceIdVO> utteranceIds}) ids;
    try {
      ids = await _repo.saveSpeakingChatAnswer(answer);
    } catch (e, s) {
      await _repo.deleteSpeakingUserAnswer(ids.id); // rollback

      _logger.e(e, stackTrace: s);
      throw ControllerException(
        'persist recording file error',
        exception: e,
        stackTrace: s,
      );
    }

    return ids.id;
  }

  /// Deletes all the recording files.
  Future<void> deleteAllRecordingFiles() async {
    _recordingFileUuidMap.forEach((i, uuid) async {
      await _deleteRecordingFile(i);
    });
  }

  /// Starts recording the user's speech in the message at the given index.
  Future<void> startRecording(int index) async {
    try {
      await _deleteRecordingFile(index); // deletes old file
      _currentRecordingIndex = index;
      _recordingFileUuidMap[index] = await _recordingSrv.startRecording();
      _recordingState[_currentRecordingIndex] =
          (_recordingState[_currentRecordingIndex] == 2) ? 3 : 1;
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _recordingState[index] = 0;
      _currentRecordingIndex = -1;
      throw ControllerException('start recording error');
    } finally {
      notifyListeners();
    }
  }

  /// Stops the curently recording.
  Future<void> stopRecording() async {
    try {
      if (isRecording) {
        await _recordingSrv.stopRecording();
        _recordingState[_currentRecordingIndex] = 2; // recorded

        // Updates audio file UUID
        _messages[_currentRecordingIndex] = _messages[_currentRecordingIndex]
            .copyWith(
              audioFileUuid: _recordingFileUuidMap[_currentRecordingIndex],
            );
      }
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _recordingState[_currentRecordingIndex] = 0;
    }

    _currentRecordingIndex = -1;
    notifyListeners();
  }

  /// Starts playing the recorded speech for the message at the given index.
  Future<void> startPlaying(int index) async {
    _currentPlayingIndex = index;

    try {
      await _recordingSrv.playAudio(_recordingFileUuidMap[index]!);
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      _currentPlayingIndex = -1;
      throw ControllerException('playback error');
    } finally {
      notifyListeners();
    }
  }

  /// Stops playing the currently playing recorded speech.
  Future<void> stopPlaying() async {
    _currentPlayingIndex = -1;

    try {
      await _recordingSrv.stopAudio();
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
    }

    notifyListeners();
  }

  /// Called when the play stops.
  void _onPlayerComplete() {
    _currentPlayingIndex = -1;

    notifyListeners();
  }

  /// Deletes the recording file at the given index.
  Future<void> _deleteRecordingFile(int index) async {
    if (_recordingFileUuidMap[index]?.isNotEmpty ?? false) {
      await _recordingSrv.deleteRecordingFile(_recordingFileUuidMap[index]!);
      _recordingFileUuidMap.remove(index);
    }
  }
}
