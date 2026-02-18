/// Prompt types of Writing Task.
enum WritingPromptType {
  // Task1
  table,
  chart,
  process,
  map,
  graph,

  // Task2
  discussionEssay,
  problemAndSolution,
  opinionEssay,
  twoPartQuestionEssay,
  advantagesAndDisadvantages;

  /// Returns whether this type belongs to Task 1.
  bool get isTask1 {
    return this == table ||
        this == chart ||
        this == process ||
        this == map ||
        this == graph;
  }

  /// Returns whether this type belongs to Task 2.
  bool get isTask2 {
    return this == discussionEssay ||
        this == problemAndSolution ||
        this == opinionEssay ||
        this == twoPartQuestionEssay ||
        this == advantagesAndDisadvantages;
  }

  /// Creates WritingPromptType from the given string.
  static WritingPromptType fromString(String name) {
    bool valid = WritingPromptType.values.any((e) => e.name == name);
    if (!valid) {
      throw ArgumentError("$name is not in WritingPromptType");
    }

    return WritingPromptType.values.firstWhere((e) => e.name == name);
  }

  /// Returns the diagram type name.
  String get task1DiagramType {
    if (isTask2) {
      throw ArgumentError("$name is not Task 1");
    }
    return name;
  }

  /// Returns the diagram type to pass the API.
  String get diagramType {
    if (isTask2) {
      throw StateError('Task 1 only has diagram type.');
    }

    switch (this) {
      case WritingPromptType.table:
        return 'table';
      case WritingPromptType.chart:
        return 'chart';
      case WritingPromptType.process:
        return 'process';
      case WritingPromptType.map:
        return 'map';
      case WritingPromptType.graph:
        return 'graph';
      default:
        throw StateError('Invalid type: $this');
    }
  }

  /// Returns the essay type to pass the API.
  String get essayType {
    if (isTask1) {
      throw StateError('Task 2 only has essay type.');
    }
    switch (this) {
      case WritingPromptType.discussionEssay:
        return 'discussion';
      case WritingPromptType.problemAndSolution:
        return 'problem_solution';
      case WritingPromptType.opinionEssay:
        return 'opinion';
      case WritingPromptType.twoPartQuestionEssay:
        return 'two_part_question';
      case WritingPromptType.advantagesAndDisadvantages:
        return 'advantage_and_disadvantage';
      default:
        throw StateError('Invalid type: $this');
    }
  }
}
