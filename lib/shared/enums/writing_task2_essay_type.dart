/// The essay types of Writing Task 2.
enum WritingTask2EssayType {
  discussionEssay,
  problemAndSolution,
  opinionEssay,
  twoPartQuestionEssay,
  advantagesAndDisadvantages,

  // static bool contains(String name) {
  //   return WritingTask1QuestionType.values.any((e) => e.name == name);
  // }

  // static WritingTask1QuestionType fromString(String name) {
  //   bool valid = WritingTask1QuestionType.values.any((e) => e.name == name);
  //   if (!valid) {
  //     throw ArgumentError("$name is not in WritingTask1QuestionType");
  //   }

  //   return WritingTask1QuestionType.values.firstWhere((e) => e.name == name);
  // }
}
