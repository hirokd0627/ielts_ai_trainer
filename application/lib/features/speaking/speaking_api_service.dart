import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';
import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// API service for the Speaking screens, generating prompts and evaluating answers.
class SpeakingApiService with ApiRequester {
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

  /// Generates initial prompt based on the given topics.
  Future<SpeakingReply> generateInitialChatReply(
    int topicCount,
    List<String> topics,
  ) async {
    final data = {'topic_count': topicCount, 'topics': topics};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'speaking/part1/generate-prompt',
      dataJson,
    );
    return SpeakingReply.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }

  /// Generates a reply message used in Speaking Part 1 & 3.
  Future<SpeakingReply> generateChatReply(String chatId, String reply) async {
    final data = {'prompt_id': chatId, 'reply': reply};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'speaking/part1/generate-prompt',
      dataJson,
    );
    return SpeakingReply.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
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
class SpeakingReply {
  /// ID to identify a convarsation.
  final String chatId;

  /// Generated reply message.
  final String message;

  /// Whether a conversation is ended.
  final bool isChatEnded;

  /// Topics to generate the first reply.
  final List<String>? topics;

  const SpeakingReply({
    required this.message,
    required this.chatId,
    required this.isChatEnded,
    required this.topics,
  });

  factory SpeakingReply.fromJson(Map<String, dynamic> json) {
    final topics = json.containsKey('topics')
        ? (json['topics'] as List<dynamic>)
              .map((topic) => topic.toString())
              .toList()
        : null;

    return SpeakingReply(
      chatId: json['prompt_id'],
      message: json['question'],
      isChatEnded: json['end_mark'],
      topics: topics,
    );
  }
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
