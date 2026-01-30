import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

part 'user_answer_vm.freezed.dart';

/// ViewModel that represents a UserAnswer for display on Home screen.
@freezed
abstract class UserAnswerVM with _$UserAnswerVM {
  const factory UserAnswerVM({
    required TestTask testTask,
    required DateTime createdAt,
  }) = _UserAnswerVM;
}
