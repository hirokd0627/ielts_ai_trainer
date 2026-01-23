import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';

part 'speaking_speech_answer.freezed.dart';

/// User's answer entity for the Speaking Part 2.
@freezed
abstract class SpeakingSpeechAnswer with _$SpeakingSpeechAnswer {
  const factory SpeakingSpeechAnswer({
    int? id,
    int? detailId,
    int? utteranceId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String promptText,
    required List<PromptTopic> topics,
    required String answerText,
    required int duration,
    required bool isGraded,
    String? note,
    double? coherence,
    double? lexial,
    double? grammatical,
    double? fluency,
    double? score,
    String? feedback,
  }) = _SpeakingSpeechAnswer;
}
