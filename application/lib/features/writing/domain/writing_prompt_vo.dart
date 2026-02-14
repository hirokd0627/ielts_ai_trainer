import 'package:freezed_annotation/freezed_annotation.dart';

part 'writing_prompt_vo.freezed.dart';

/// Value object that represents Writing prompt components.
@freezed
class WritingPromptVo {
  final String taskContext, taskInstruction;
  String? diagramDescription;
  String? diagramUuid;

  WritingPromptVo({
    required this.taskContext,
    required this.taskInstruction,
    this.diagramDescription,
    this.diagramUuid,
  });

  String get promptText {
    return "$taskContext $taskInstruction";
  }
}
