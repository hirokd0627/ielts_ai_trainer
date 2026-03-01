import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaking_utterance_vo.freezed.dart';

/// Value object that represents a SpeakingUtterance.
@freezed
abstract class SpeakingUtteranceVO with _$SpeakingUtteranceVO {
  const factory SpeakingUtteranceVO({
    required int order,
    required bool isUser,
    required String text,
    required bool isGraded,
    String? audioFileUuid,
    double? pronunciationScore,
    double? fluencyScore,
  }) = _SpeakingUtteranceVO;
}
