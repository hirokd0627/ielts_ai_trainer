import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaking_utterance_id_vo.freezed.dart';

/// Value object that represents the ID of a SpeakingUtterance.
@freezed
abstract class SpeakingUtteranceIdVO with _$SpeakingUtteranceIdVO {
  const factory SpeakingUtteranceIdVO({
    required int userAnswerId,
    required int order,
  }) = _SpeakingUtteranceIdVO;
}
