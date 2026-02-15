import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/shared/domain/score_calculation_service.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

part 'speaking_chat_answer.freezed.dart';

/// User's answer entity for the Speaking Part 1 & 3.
@freezed
abstract class SpeakingChatAnswer with _$SpeakingChatAnswer {
  const SpeakingChatAnswer._();

  const factory SpeakingChatAnswer({
    int? id,
    int? detailId,
    required List<SpeakingUtteranceVO> utterances,
    required DateTime createdAt,
    required List<PromptTopic> topics,
    required int duration,
    required bool isGraded,
    required TestTask testTask,
    double? coherenceScore,
    double? lexicalScore,
    double? grammaticalScore,
    String? coherenceFeedback,
    String? lexicalFeedback,
    String? grammaticalFeedback,
  }) = _SpeakingChatAnswer;

  /// Whether the fluency score can be calculated.
  bool get hasFluencyScore {
    for (final u in utterances) {
      if (u.isUser && u.isGraded && u.fluency != null) {
        return true;
      }
    }
    return false;
  }

  /// Returns the fluency score.
  double get fluencyScore {
    final scores = <double>[];
    for (final u in utterances) {
      if (u.isUser && u.isGraded && u.fluency != null) {
        scores.add(u.fluency!);
      }
    }
    return ScoreCalculationService.calculateScore(scores);
  }
}
