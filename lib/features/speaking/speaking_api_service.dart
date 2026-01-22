import 'package:faker/faker.dart';

/// API service for Speaking Topic screens.
class SpeakingApiService {
  /// Generates a writing prompt text beased on the given topics.
  Future<SpeakingPromptResponse> generatePromptText(
    int topicCount,
    List<String> topics,
  ) async {
    // TODO: dummy data

    // TODO: if the number of topics is less than topicCount, generates topics to fill the gap.

    var usedTopics = [...topics];
    if (topicCount > topics.length) {
      final faker = Faker();
      for (int i = topics.length; i < topicCount; i++) {
        usedTopics.add(faker.lorem.word());
      }
    }

    await Future.delayed(const Duration(seconds: 2));
    return SpeakingPromptResponse(
      promptText: faker.lorem.sentences(3).join("\n"),
      topics: usedTopics,
    );
  }

  /// Grades the given writing answer.
  //   Future<SpeakingGradingResponse> gradeAnswer({
  //     required TestTask testTask,
  //     required WritingPromptType promptType,
  //     required String promptText,
  //     required String answerText,
  //   }) async {
  //     // TODO: dummy data
  //     await Future.delayed(const Duration(seconds: 2));
  //     return SpeakingGradingResponse(
  //       achievement:
  //           (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
  //       coherence:
  //           (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
  //       lexial: (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
  //       grammatical:
  //           (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
  //       score: (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
  //       feedback: faker.lorem.sentences(3).join("\n"),
  //     );
  //   }
}

/// Response for speaking prompt generation.
class SpeakingPromptResponse {
  /// Generated prompt text.
  final String promptText;

  /// Topics used to gnerate the prompt text.
  final List<String> topics;

  const SpeakingPromptResponse({
    required this.promptText,
    required this.topics,
  });
}

// /// Response of the result of grading a writing answer.
// class SpeakingGradingResponse {
//   final double achievement;
//   final double coherence;
//   final double lexial;
//   final double grammatical;
//   final double score;
//   final String feedback;

//   const SpeakingGradingResponse({
//     required this.achievement,
//     required this.coherence,
//     required this.lexial,
//     required this.grammatical,
//     required this.score,
//     required this.feedback,
//   });
// }
