import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_id_vo.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

/// UtteranceRecordingService for the Speaking answer input screens, recording the user's speech.
class UtteranceRecordingService {
  /// The audio recorder to record the user's speech.
  final AudioRecorder _audioRecorder = AudioRecorder();

  /// The audio player to play the recorded audio file.
  final _audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  /// A subscription called when audio playback completes.
  late final StreamSubscription _playerCompleteSubscription;

  /// Functions to handles the event that an audio playing stops.
  final void Function() _onPlayerComplete;

  UtteranceRecordingService({required void Function() onPlayerComplete})
    : _onPlayerComplete = onPlayerComplete {
    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      return _onPlayerComplete();
    });
  }

  void dispose() {
    _playerCompleteSubscription.cancel();
  }

  /// Starts recording the user's speech, and returns the UUID for the recorded audio file.
  Future<String> startRecording() async {
    // Check permission for audio recording.
    if (!(await _audioRecorder.hasPermission())) {
      throw UnsupportedError('Audio recording permission denied.');
    }

    // Save a file using AAC codec.
    const encoder = AudioEncoder.aacLc;
    if (!await _isEncoderSupported(encoder)) {
      throw UnsupportedError(
        'aacLc encoder is not supported on this platform.',
      );
    }

    // Use mono audio.
    const config = RecordConfig(encoder: encoder, numChannels: 1);

    // Generate UUID for the identity for the temporary file.
    final uuid = Uuid().v4();
    final path = await _getTemporaryFilePath(uuid);

    // Start to record.
    await _audioRecorder.start(config, path: path);

    return uuid;
  }

  /// Stops the recording and returns the file path.
  Future<String> stopRecording() async {
    final path = await _audioRecorder.stop();
    return path ?? '';
  }

  /// Returns the path of the persistent file for the recording file.
  Future<String> getPersistentFilePath(
    SpeakingUtteranceIdVO utteranceId,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(
      dir.path,
      '${utteranceId.userAnswerId}_${utteranceId.order}.m4a',
    );
  }

  /// Persists the recording file for the UUID and returns the file path.
  Future<String> persistRecordingFile(
    SpeakingUtteranceIdVO utteranceId,
    String uuid,
  ) async {
    final srcPath = await _getTemporaryFilePath(uuid);
    final dstPath = await getPersistentFilePath(utteranceId);

    // Copy
    final srcFile = File(srcPath);
    await srcFile.copy(dstPath);

    // Delete the temporary file.
    final dstFile = File(dstPath);
    if (await dstFile.exists() == false) {
      throw Exception('failed to persist audio file.');
    }
    // delete after confirming the copied file
    await srcFile.delete();

    return dstPath;
  }

  /// Deletes the temporary recording file.
  Future<void> deleteTemporaryRecordingFile(String uuid) async {
    final path = await _getTemporaryFilePath(uuid);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Starts playing the audio file for the given UUID.
  Future<void> playAudio(String uuid) async {
    await _audioPlayer.setSource(
      DeviceFileSource(await _getTemporaryFilePath(uuid)),
    );
    await _audioPlayer.resume();
  }

  /// Starts playing the audio file for the given utterance id.
  Future<void> playAudioById(SpeakingUtteranceIdVO utteranceId) async {
    await _audioPlayer.setSource(
      DeviceFileSource(await getPersistentFilePath(utteranceId)),
    );
    await _audioPlayer.resume();
  }

  /// Stops the currently playing.
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  /// Returns true if a recording file exists for the given utterance id.
  Future<bool> recordingFileExists(SpeakingUtteranceIdVO utteranceId) async {
    final path = await getPersistentFilePath(utteranceId);
    final file = File(path);
    return await file.exists();
  }

  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _audioRecorder.isEncoderSupported(encoder);

    if (!isSupported) {
      debugPrint('${encoder.name} is not supported on this platform.');
      debugPrint('Supported encoders are:');

      for (final e in AudioEncoder.values) {
        if (await _audioRecorder.isEncoderSupported(e)) {
          debugPrint('- ${e.name}');
        }
      }
    }

    return isSupported;
  }

  /// Returns the temporary file path for the recording file.
  Future<String> _getTemporaryFilePath(String uuid) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'tmp_$uuid.m4a');
  }
}
