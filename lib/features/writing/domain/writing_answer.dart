import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

part 'writing_answer.freezed.dart';

/// User's answer entity of Writing task.
@freezed
abstract class WritingAnswer with _$WritingAnswer {
  const factory WritingAnswer({
    int? id,
    int? detailId,
    required TestTask testTask,
    required DateTime createdAt,
    required DateTime updatedAt,
    required WritingPromptType promptType,
    required String promptText,
    required List<WritingTopic> topics,
    required String answerText,
    required int duration,
    required bool isGraded,
    double? achievement,
    double? coherence,
    double? lexial,
    double? grammatical,
    double? score,
    String? feedback,
  }) = _WritingAnswer;
}
