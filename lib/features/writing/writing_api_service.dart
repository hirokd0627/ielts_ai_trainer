import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

/// API service for Writing Task screens.
class WritingApiService {
  /// Generates a writing prompt text beased on the given topics.
  Future<WritingPromptResponse> generatePromptText(List<String> topics) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));
    return WritingPromptResponse(faker.lorem.sentences(3).join("\n"));
  }

  /// Grades the given writing answer.
  Future<WritingGradingResponse> gradeAnswer({
    required TestTask testTask,
    required WritingPromptType promptType,
    required String promptText,
    required String answerText,
  }) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));
    return WritingGradingResponse(
      achievement:
          (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      coherence:
          (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      lexial: (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      grammatical:
          (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      score: (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      feedback: faker.lorem.sentences(3).join("\n"),
    );
  }
}

/// Response for writing prompt generation.
class WritingPromptResponse {
  /// Generated prompt text.
  final String promptText;

  const WritingPromptResponse(this.promptText);
}

/// Response of the result of grading a writing answer.
class WritingGradingResponse {
  final double achievement;
  final double coherence;
  final double lexial;
  final double grammatical;
  final double score;
  final String feedback;

  const WritingGradingResponse({
    required this.achievement,
    required this.coherence,
    required this.lexial,
    required this.grammatical,
    required this.score,
    required this.feedback,
  });
}
