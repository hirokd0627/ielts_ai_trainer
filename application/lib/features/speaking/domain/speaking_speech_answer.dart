import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';

part 'speaking_speech_answer.freezed.dart';

/// User's answer entity for the Speaking Part 2.
@freezed
abstract class SpeakingSpeechAnswer with _$SpeakingSpeechAnswer {
  const SpeakingSpeechAnswer._();

  const factory SpeakingSpeechAnswer({
    int? id,
    int? detailId,
    int? utteranceId,
    required DateTime createdAt,
    required SpeakingUtteranceVO prompt,
    required List<PromptTopic> topics,
    required SpeakingUtteranceVO answer,
    required int duration,
    required bool isGraded,
    String? note,
    double? coherenceScore,
    double? lexicalScore,
    double? grammaticalScore,
    String? coherenceFeedback,
    String? lexicalFeedback,
    String? grammaticalFeedback,
  }) = _SpeakingSpeechAnswer;

  /// Whether the pronunciation score can be calculated.
  bool get hasPronunciationScore {
    return answer.isGraded;
  }

  /// Returns the pronunciation score.
  double get pronunciationScore {
    return answer.pronunciationScore ?? 0.0;
  }
}
