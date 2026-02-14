import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
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
    required SpeakingUtteranceVO prompt,
    required List<PromptTopic> topics,
    required SpeakingUtteranceVO answer,
    required int duration,
    required bool isGraded,
    String? note,
    double? coherenceScore,
    double? lexicalScore,
    double? grammaticalScore,
    double? fluencyScore,
    double? bandScore,
    String? coherenceFeedback,
    String? lexicalFeedback,
    String? grammaticalFeedback,
    String? fluencyFeedback,
  }) = _SpeakingSpeechAnswer;
}
