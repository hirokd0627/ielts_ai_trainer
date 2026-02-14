import 'dart:convert';

import 'package:ielts_ai_trainer/shared/api/common_api_service.dart';
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

  /// Evaluate the given answer for Writing Task 1.
  Future<WritingEvaluationResponse> evaluateTask1Answer({
    required String promptText,
    required WritingPromptType promptType,
    required String diagramDescription,
    required String answerText,
  }) async {
    final data = {
      'prompt': promptText,
      'diagram_type': promptType.task1DiagramType,
      'diagram_description': diagramDescription,
      'answer': answerText,
    };
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest('writing/task1/evaluate', dataJson);
    return WritingEvaluationResponse.fromTask1Json(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }

  /// Evaluate the given answer for Writing Task 2.
  Future<WritingEvaluationResponse> evaluateTask2Answer({
    required String promptText,
    required String answerText,
  }) async {
    final data = {'prompt': promptText, 'answer': answerText};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest('writing/task2/evaluate', dataJson);
    return WritingEvaluationResponse.fromTask2Json(
      jsonDecode(resp.body) as Map<String, dynamic>,
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

/// Response of evaluateTask1Answer.
class WritingEvaluationResponse {
  final double taskScore,
      coherenceScore,
      grammaticalScore,
      lexialScore,
      bandScore;
  final List<String> taskFeedback,
      coherenceFeedback,
      grammaticalFeedback,
      lexicalFeedback;

  const WritingEvaluationResponse({
    required this.taskScore,
    required this.coherenceScore,
    required this.grammaticalScore,
    required this.lexialScore,
    required this.bandScore,
    required this.taskFeedback,
    required this.coherenceFeedback,
    required this.grammaticalFeedback,
    required this.lexicalFeedback,
  });

  /// Creaates WritingEvaluationResponse with the response of Task 1.
  factory WritingEvaluationResponse.fromTask1Json(Map<String, dynamic> json) {
    for (var name in ["achievement_score", "achievement_feedback"]) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }
    return _fromJson(
      json["achievement_score"],
      List<String>.from(json["achievement_feedback"]),
      json,
    );
  }

  /// Creaates WritingEvaluationResponse with the response of Task 2.
  factory WritingEvaluationResponse.fromTask2Json(Map<String, dynamic> json) {
    for (var name in ["response_score", "response_feedback"]) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }
    return _fromJson(
      json["response_score"],
      List<String>.from(json["response_feedback"]),
      json,
    );
  }

  static WritingEvaluationResponse _fromJson(
    double taskScore,
    List<String> taskFeedback,
    Map<String, dynamic> json,
  ) {
    for (var name in [
      "coherence_score",
      "grammatical_score",
      "lexical_score",
      "band_score",
      "coherence_feedback",
      "grammatical_feedback",
      "lexical_feedback",
    ]) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }

    return WritingEvaluationResponse(
      taskScore: taskScore,
      coherenceScore: json["coherence_score"],
      grammaticalScore: json["grammatical_score"],
      lexialScore: json["lexical_score"],
      bandScore: json["band_score"],
      taskFeedback: taskFeedback,
      coherenceFeedback: List<String>.from(json["coherence_feedback"]),
      grammaticalFeedback: List<String>.from(json["grammatical_feedback"]),
      lexicalFeedback: List<String>.from(json["lexical_feedback"]),
    );
  }
}
