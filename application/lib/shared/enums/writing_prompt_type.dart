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
}
