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
