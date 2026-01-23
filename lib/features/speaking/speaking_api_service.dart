import 'package:faker/faker.dart';

/// API service for the Speaking screens, generating prompts and evaluating answers.
class SpeakingApiService {
  /// Generates prompt text based on the given topics.
  Future<SpeakingPromptResponse> generatePromptText(
    int topicCount,
    List<String> topics,
  ) async {
    // TODO: dummy data

    // If the number of topics is less than topicCount, generates topics to fill the gap.
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

  /// Generates a reply message used in Speaking Part 1 & 3.
  Future<SpeakingReplyResponse> generateChatReply(String userMessage) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));
    return SpeakingReplyResponse(message: faker.lorem.sentences(2).join("\n"));
  }
}

/// Response for speaking prompt generation.
class SpeakingPromptResponse {
  /// Generated prompt text.
  final String promptText;

  /// Topics used to generate the prompt text.
  final List<String> topics;

  const SpeakingPromptResponse({
    required this.promptText,
    required this.topics,
  });
}

/// Response for speaking reply generation.
class SpeakingReplyResponse {
  /// Generated reply message.
  final String message;

  const SpeakingReplyResponse({required this.message});
}
