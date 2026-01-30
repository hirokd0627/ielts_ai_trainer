import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

part 'speaking_chat_answer.freezed.dart';

/// User's answer entity for the Speaking Part 1 & 3.
@freezed
abstract class SpeakingChatAnswer with _$SpeakingChatAnswer {
  const factory SpeakingChatAnswer({
    int? id,
    int? detailId,
    required List<SpeakingUtteranceVO> utterances,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<PromptTopic> topics,
    required int duration,
    required bool isGraded,
    required TestTask testTask,
    double? coherence,
    double? lexial,
    double? grammatical,
    double? fluency,
    double? score,
    String? feedback,
  }) = _SpeakingChatAnswer;
}
