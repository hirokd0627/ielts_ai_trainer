import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';
import 'package:ielts_ai_trainer/shared/api/common_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// API service for the Speaking screens, generating prompts and evaluating answers.
class SpeakingApiService with ApiRequester, TopicApiService {
  // /// Generates prompt text based on the given topics.
  // Future<SpeakingPromptResponse> generatePromptText(
  //   int topicCount,
  //   List<String> topics,
  // ) async {
  //   // TODO: dummy data

  //   // If the number of topics is less than topicCount, generates topics to fill the gap.
  //   var usedTopics = [...topics];
  //   if (topicCount > topics.length) {
  //     final faker = Faker();
  //     for (int i = topics.length; i < topicCount; i++) {
  //       usedTopics.add(faker.lorem.word());
  //     }
  //   }

  //   await Future.delayed(const Duration(seconds: 2));
  //   return SpeakingPromptResponse(
  //     promptText: faker.lorem.sentences(3).join("\n"),
  //     topics: usedTopics,
  //   );
  // }

  // /// Generates initial prompt based on the given topics.
  // Future<SpeakingReply> generateInitialChatReply(
  //   int topicCount,
  //   List<String> topics,
  // ) async {
  //   final data = {'topic_count': topicCount, 'topics': topics};
  //   final dataJson = jsonEncode(data);
  //   final resp = await sendPostRequest(
  //     'speaking/part1/generate-prompt',
  //     dataJson,
  //   );
  //   return SpeakingReply.fromJson(
  //     jsonDecode(resp.body) as Map<String, dynamic>,
  //   );
  // }

  // /// Generates a reply message used in Speaking Part 1 & 3.
  // Future<SpeakingReply> generateChatReply(
  //   String interactionId,
  //   String reply,
  // ) async {
  //   final data = {'prompt_id': interactionId, 'reply': reply};
  //   final dataJson = jsonEncode(data);
  //   final resp = await sendPostRequest(
  //     'speaking/part1/generate-prompt',
  //     dataJson,
  //   );
  //   return SpeakingReply.fromJson(
  //     jsonDecode(resp.body) as Map<String, dynamic>,
  //   );
  // }

  /// Generates initial question of Part 1 or Part 3.
  Future<SpeakingQuestionResponse> generateInitialQuestion(
    int partNo,
    String topic,
  ) async {
    return await _generateQuestion(partNo, topic: topic);
  }

  /// Generates a subsequent question of Part 1 or Part 3 following the initial question.
  Future<SpeakingQuestionResponse> generateSubsequentQuestion(
    int partNo,
    String interactionId,
    String reply,
  ) async {
    return await _generateQuestion(
      partNo,
      interactionId: interactionId,
      reply: reply,
    );
  }

  /// Generates Part2 cue card content.
  Future<SpeakingCuecardResponse> generatePart2CuecardContent(
    String topic,
  ) async {
    final data = {'topic': topic};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'speaking/part2/generate-prompt',
      dataJson,
    );
    return SpeakingCuecardResponse.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }

  /// Generates a question of Part 1 or Part 3.
  Future<SpeakingQuestionResponse> _generateQuestion(
    int partNo, {
    String? topic,
    String? reply,
    String? interactionId,
  }) async {
    if (partNo != 1 && partNo != 3) {
      throw ArgumentError('part must be between 1 or 3');
    }

    final initial = topic != null;
    final data = initial
        ? {'topic': topic}
        : {'prompt_id': interactionId, 'reply': reply};

    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'speaking/part$partNo/generate-question',
      dataJson,
    );
    return SpeakingQuestionResponse.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }

  /// Gets the topic transition message.
  Future<String> generateTopicTransitionMessage(String topic) async {
    final data = {'topic': topic};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'speaking/generate-transition-message',
      dataJson,
    );

    final json = jsonDecode(resp.body);
    return json['message'];
  }

  /// Gets the closing message.
  Future<String> generateClosingMessage(TestTask testTask) async {
    final part = testTask == TestTask.speakingPart1
        ? 1
        : testTask == TestTask.speakingPart2
        ? 2
        : 3;

    final data = {'part': part};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'speaking/generate-closing-message',
      dataJson,
    );

    final json = jsonDecode(resp.body);
    return json['message'];
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

// /// Response for speaking prompt generation.
// class SpeakingPromptResponse {
//   /// Generated prompt text.
//   final String promptText;

//   /// Topics used to generate the prompt text.
//   final List<String> topics;

//   const SpeakingPromptResponse({
//     required this.promptText,
//     required this.topics,
//   });
// }

// /// Response for speaking reply generation.
// class SpeakingReply {
//   /// ID to identify a convarsation.
//   final String interactionId;

//   /// Generated reply message.
//   final String message;

//   /// Whether a conversation is ended.
//   final bool isChatEnded;

//   /// Topics to generate the first reply.
//   final List<String>? topics;

//   const SpeakingReply({
//     required this.message,
//     required this.interactionId,
//     required this.isChatEnded,
//     required this.topics,
//   });

//   factory SpeakingReply.fromJson(Map<String, dynamic> json) {
//     final topics = json.containsKey('topics')
//         ? (json['topics'] as List<dynamic>)
//               .map((topic) => topic.toString())
//               .toList()
//         : null;

//     return SpeakingReply(
//       interactionId: json['prompt_id'],
//       message: json['question'],
//       isChatEnded: json['end_mark'],
//       topics: topics,
//     );
//   }
// }

/// Response for topic generation.
class TopicResponse {
  /// Generated topics.
  final List<String> topics;

  const TopicResponse({required this.topics});

  factory TopicResponse.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('topics')) {
      throw FormatException('Missing response element: topics');
    }

    final topics = (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();
    return TopicResponse(topics: topics);
  }
}

/// Response of generateInitialQuestion and generateSubsequentQuestion.
class SpeakingQuestionResponse {
  /// Last ID to identify the current conversation.
  final String interactionId;

  /// Generated question sentence.
  final String question;

  const SpeakingQuestionResponse({
    required this.interactionId,
    required this.question,
  });

  factory SpeakingQuestionResponse.fromJson(Map<String, dynamic> json) {
    return SpeakingQuestionResponse(
      interactionId: json['prompt_id'],
      question: json['question'],
    );
  }
}

/// Response of generatePart2CuecardContent.
class SpeakingCuecardResponse {
  /// Generated prompt.
  final String prompt;

  /// Topic to generate a prompt.
  final String topic;

  const SpeakingCuecardResponse({required this.prompt, required this.topic});

  factory SpeakingCuecardResponse.fromJson(Map<String, dynamic> json) {
    final prompt =
        '''
${json['main_task']}
    You should say:
        ${json['q1']}
        ${json['q2']}
        ${json['q3']}
and explain ${json['q4']}
''';

    return SpeakingCuecardResponse(prompt: prompt, topic: json['topic']);
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
