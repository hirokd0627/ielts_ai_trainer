import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
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

    // Save a file using WAV codec.
    const encoder = AudioEncoder.wav;
    if (!await _isEncoderSupported(encoder)) {
      throw UnsupportedError(
        'aacLc encoder is not supported on this platform.',
      );
    }

    // Use mono audio.
    const config = RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 16000,
      bitRate: 256000,
      numChannels: 1,
    );

    // Generate UUID for the identity for the audio file.
    final uuid = Uuid().v4();
    final path = await getFilePath(uuid);

    // Start to record.
    await _audioRecorder.start(config, path: path);

    return uuid;
  }

  /// Stops the recording and returns the file path.
  Future<String> stopRecording() async {
    final path = await _audioRecorder.stop();
    return path ?? '';
  }

  /// Deletes the recording file.
  Future<void> deleteRecordingFile(String uuid) async {
    final path = await getFilePath(uuid);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Starts playing the audio file for the given UUID.
  Future<void> playAudio(String uuid) async {
    final path = await getFilePath(uuid);
    await _audioPlayer.setSource(DeviceFileSource(path));
    await _audioPlayer.resume();
  }

  /// Stops the currently playing.
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  /// Returns true if a recording file exists for the given UUID.
  Future<bool> recordingFileExists(String uuid) async {
    final path = await getFilePath(uuid);
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

  /// Returns the path of the recording file.
  Future<String> getFilePath(String uuid) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, '$uuid.wav');
  }
}
