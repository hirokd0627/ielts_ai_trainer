import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/shared/api/common_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// API service for the Writing screens, generating prompts and evaluating answers.
class WritingApiService with ApiRequester, TopicApiService {
  /// Generates Writing Task 1 prompt based on the given diagram type and topics.
  Future<WritingTask1Response> generateTask1Prompt(
    String diagramType,
    List<String> topics,
  ) async {
    final data = {'diagram_type': diagramType, 'topics': topics};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'writing/task1/generate-prompt',
      dataJson,
    );
    return WritingTask1Response.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }

  /// Generates Writing Task 2 prompt based on the given essay type and topics.
  Future<WritingTask2Response> generateTask2Prompt(
    String essayType,
    List<String> topics,
  ) async {
    final data = {'essay_type': essayType, 'topics': topics};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(
      'writing/task2/generate-prompt',
      dataJson,
    );
    return WritingTask2Response.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
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

/// Response of generateTask1Prompt.
class WritingTask1Response {
  /// Prompt introduction.
  final String introduction;

  /// Base64 encoded string of the diagram.
  final String diagramData;

  /// Description of the diagram.
  final String diagramDescription;

  /// Prompt instruction.
  final String instruction;

  /// Topics used to generate the prompt text.
  final List<String> topics;

  const WritingTask1Response({
    required this.introduction,
    required this.diagramData,
    required this.diagramDescription,
    required this.instruction,
    required this.topics,
  });

  factory WritingTask1Response.fromJson(Map<String, dynamic> json) {
    for (var name in [
      'topics',
      'instruction',
      'introduction',
      'diagram_description',
      'diagram_data',
    ]) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }

    final topics = (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();

    return WritingTask1Response(
      instruction: json['instruction'],
      topics: topics,
      diagramData: json['diagram_data'],
      introduction: json['introduction'],
      diagramDescription: json['diagram_description'],
    );
  }
}

/// Response of generateTask2Prompt.
class WritingTask2Response {
  /// Statement text.
  final String statement;

  /// Instruction text.
  final String instruction;

  /// Topics used to generate the prompt text.
  final List<String> topics;

  const WritingTask2Response({
    required this.statement,
    required this.instruction,
    required this.topics,
  });

  factory WritingTask2Response.fromJson(Map<String, dynamic> json) {
    for (var name in ['topics', 'statement', 'instruction']) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }

    final topics = (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();

    return WritingTask2Response(
      statement: json['statement'],
      instruction: json['instruction'],
      topics: topics,
    );
  }
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
