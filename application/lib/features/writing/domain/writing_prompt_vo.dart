import 'package:freezed_annotation/freezed_annotation.dart';

part 'writing_prompt_vo.freezed.dart';

/// Value object that represents Writing prompt components.
@freezed
abstract class WritingPromptVo with _$WritingPromptVo {
  const WritingPromptVo._();

  const factory WritingPromptVo({
    required String taskContext,
    required String taskInstruction,
    String? diagramDescription,
    String? diagramUuid,
  }) = _WritingPromptVo;

  String get promptText {
    return "$taskContext $taskInstruction";
  }
}
