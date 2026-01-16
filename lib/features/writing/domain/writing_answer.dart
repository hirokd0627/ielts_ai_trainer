import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task1_question_type.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_task2_essay_type.dart';

part 'writing_answer.freezed.dart';

/// User's answer entity of Writing task.
@freezed
abstract class WritingAnswer with _$WritingAnswer {
  const factory WritingAnswer({
    int? id,
    int? detailId,
    required TestTask testTask,
    required DateTime createdAt,
    required String promptText,
    required List<String> topics,
    required String answerText,
    required int duration,
    required bool isGraded,
    double? achievement,
    double? coherence,
    double? lexial,
    double? grammatical,
    double? score,
    String? feedback,
    WritingTask1QuestionType? questionType,
    WritingTask2EssayType? essayType,
  }) = _WritingAnswer;
}
