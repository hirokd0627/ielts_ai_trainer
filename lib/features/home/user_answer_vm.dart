import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_answer_vm.freezed.dart';

/// ViewModel representing a UserAnswer for display on Home screen
@freezed
abstract class UserAnswerVM with _$UserAnswerVM {
  const factory UserAnswerVM({required DateTime createdAt}) = _UserAnswerVM;
}
