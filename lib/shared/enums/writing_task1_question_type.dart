/// The types of Writing Task1
enum WritingTask1QuestionType {
  table,
  chart,
  process,
  map,
  graph;

  static bool contains(String name) {
    return WritingTask1QuestionType.values.any((e) => e.name == name);
  }

  static WritingTask1QuestionType fromString(String name) {
    bool valid = WritingTask1QuestionType.values.any((e) => e.name == name);
    if (!valid) {
      throw ArgumentError("$name is not in WritingTask1QuestionType");
    }

    return WritingTask1QuestionType.values.firstWhere((e) => e.name == name);
  }
}
