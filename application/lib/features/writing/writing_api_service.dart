import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:http/http.dart' as http;

/// API service for Writing Task screens.
class WritingApiService {
  /// API key.
  static const String _apiKey = String.fromEnvironment('API_KEY');

  /// API base URL.
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Generates Writing Task 1 prompt based on the given topics.
  Future<WritingTask1Prompt> generateTask1Prompt(List<String> topics) async {
    final data = {'topics': topics};
    final dataJson = jsonEncode(data);
    final resp = await _sendPostRequest(
      'writing/task1/generate-prompt',
      dataJson,
    );
    return WritingTask1Prompt.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }

  /// Generates Writing Task 2 prompt based on the given topics.
  Future<WritingTask2Prompt> generateTask2Prompt(List<String> topics) async {
    final data = {'topics': topics};
    final dataJson = jsonEncode(data);
    final resp = await _sendPostRequest(
      'writing/task2/generate-prompt',
      dataJson,
    );
    return WritingTask2Prompt.fromJson(
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

  /// Send a POST request to the backend API.
  Future<http.Response> _sendPostRequest(String endpoint, Object json) {
    print(_apiBaseUrl);
    print(_apiKey);
    return http.post(
      Uri.parse('$_apiBaseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-KEY': _apiKey,
      },
      body: json,
    );
  }
}

/// Generated Wwriting Task 1 prompt from the backend API.
class WritingTask1Prompt {
  /// Prompt text.
  final String prompt;

  /// Topics used to generate the prompt text.
  final List<String> topics;

  /// Base64 encoded string of the diagram.
  final String imageBase64;

  /// Introduction for the diagram.
  final String introduction;

  /// Description of the diagram.
  final String description;

  const WritingTask1Prompt({
    required this.prompt,
    required this.topics,
    required this.imageBase64,
    required this.introduction,
    required this.description,
  });

  factory WritingTask1Prompt.fromJson(Map<String, dynamic> json) {
    for (var name in [
      'topics',
      'instruction',
      'introduction',
      'diagram_description',
      'img_b64',
    ]) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }

    final topics = (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();

    return WritingTask1Prompt(
      prompt: json['instruction'],
      topics: topics,
      imageBase64: json['img_b64'],
      introduction: json['introduction'],
      description: json['diagram_description'],
    );
  }
}

/// Generated Writing Task 2 prompt from the backend API.
class WritingTask2Prompt {
  /// Statement text.
  final String statement;

  /// Instruction text.
  final String instruction;

  /// Topics used to generate the prompt text.
  final List<String> topics;

  const WritingTask2Prompt({
    required this.statement,
    required this.instruction,
    required this.topics,
  });

  factory WritingTask2Prompt.fromJson(Map<String, dynamic> json) {
    for (var name in ['topics', 'statement', 'instruction']) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }

    final topics = (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();

    return WritingTask2Prompt(
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
