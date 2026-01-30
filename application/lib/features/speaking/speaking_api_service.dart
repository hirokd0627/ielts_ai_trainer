import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';

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

  /// Grades the given speaking chat answer.
  Future<SpeakingChatGradingResponse> gradeChatAnswer({
    required SpeakingChatAnswer answer,
  }) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));

    final fluencyScores = List.generate(answer.utterances.length, (_) {
      return (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2;
    });

    return SpeakingChatGradingResponse(
      fluency:
          (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      coherence:
          (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      lexial: (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      grammatical:
          (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      score: (faker.randomGenerator.decimal(min: 0, scale: 9) * 2).round() / 2,
      feedback: faker.lorem.sentences(3).join("\n"),
      utteranceFluency: fluencyScores,
    );
  }

  /// Grades the given speaking speech answer.
  Future<SpeakingSpeechGradingResponse> gradeSpeechAnswer({
    required SpeakingSpeechAnswer answer,
  }) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));

    return SpeakingSpeechGradingResponse(
      fluency:
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

/// Result of grading a speaking chat answer.
class SpeakingChatGradingResponse {
  final double fluency;
  final double coherence;
  final double lexial;
  final double grammatical;
  final double score;
  final String feedback;
  final List<double> utteranceFluency;

  const SpeakingChatGradingResponse({
    required this.fluency,
    required this.coherence,
    required this.lexial,
    required this.grammatical,
    required this.score,
    required this.feedback,
    required this.utteranceFluency,
  });
}

/// Result of grading a speaking speech answer.
class SpeakingSpeechGradingResponse {
  final double fluency;
  final double coherence;
  final double lexial;
  final double grammatical;
  final double score;
  final String feedback;

  const SpeakingSpeechGradingResponse({
    required this.fluency,
    required this.coherence,
    required this.lexial,
    required this.grammatical,
    required this.score,
    required this.feedback,
  });
}
