import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

/// Extension of WritingPromptType for Backend API.
extension WritingPromptTypeApiExtension on WritingPromptType {
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
