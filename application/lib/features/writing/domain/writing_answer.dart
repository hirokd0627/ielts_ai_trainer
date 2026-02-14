import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

part 'writing_answer.freezed.dart';

/// User's answer entity for the Writing Tasks.
@freezed
abstract class WritingAnswer with _$WritingAnswer {
  const WritingAnswer._();

  const factory WritingAnswer({
    int? id,
    int? detailId,
    required TestTask testTask,
    required DateTime createdAt,
    required DateTime updatedAt,
    required WritingPromptType promptType,
    required WritingPromptVo writingPrompt,
    required List<PromptTopic> topics,
    required String answerText,
    required int duration,
    required bool isGraded,
    double? taskScore,
    double? coherenceScore,
    double? lexialScore,
    double? grammaticalScore,
    double? bandScore,
    String? taskFeedback,
    String? coherenceFeedback,
    String? lexialFeedback,
    String? grammaticalFeedback,
  }) = _WritingAnswer;
}
