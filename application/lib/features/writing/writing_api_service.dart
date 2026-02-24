import 'package:ielts_ai_trainer/shared/api/api_response_validator.dart';
import 'package:ielts_ai_trainer/shared/api/common_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/ai_name.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';
import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// API service for the Writing screens, generating prompts and evaluating answers.
class WritingApiService
    with ApiRequester, ApiResponseValidator, CommonApiService {
  /// Generates Writing Task 1 prompt based on the given diagram type and topic.
  Future<WritingTask1Response> generateTask1Prompt(
    String diagramType,
    String topic,
    AiName aiName,
  ) async {
    final data = {
      'diagram_type': diagramType,
      'topic': topic,
      'ai_name': aiName.aiNameArgmentValue,
    };
    final respJson = await sendJsonPostRequest(
      'writing/task1/generate-prompt',
      data,
    );
    return WritingTask1Response.fromJson(respJson);
  }

  /// Generates Writing Task 2 prompt based on the given essay type and topic.
  Future<WritingTask2Response> generateTask2Prompt(
    String essayType,
    String topic,
    AiName aiName,
  ) async {
    final data = {
      'essay_type': essayType,
      'topic': topic,
      'ai_name': aiName.aiNameArgmentValue,
    };
    final respJson = await sendJsonPostRequest(
      'writing/task2/generate-prompt',
      data,
    );
    return WritingTask2Response.fromJson(respJson);
  }

  /// Evaluate the given answer for Writing Task 1.
  Future<WritingEvaluationResponse> evaluateTask1Answer({
    required String promptText,
    required WritingPromptType promptType,
    required String diagramDescription,
    required String answerText,
    required AiName aiName,
  }) async {
    final data = {
      'prompt': promptText,
      'diagram_type': promptType.task1DiagramType,
      'diagram_description': diagramDescription,
      'answer': answerText,
      'ai_name': aiName.aiNameArgmentValue,
    };
    final respJson = await sendJsonPostRequest('writing/task1/evaluate', data);
    return WritingEvaluationResponse.fromTask1Json(respJson);
  }

  /// Evaluate the given answer for Writing Task 2.
  Future<WritingEvaluationResponse> evaluateTask2Answer({
    required String promptText,
    required String answerText,
    required AiName aiName,
  }) async {
    final data = {
      'prompt': promptText,
      'answer': answerText,
      'ai_name': aiName.aiNameArgmentValue,
    };
    final respJson = await sendJsonPostRequest('writing/task2/evaluate', data);
    return WritingEvaluationResponse.fromTask2Json(respJson);
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

  const WritingTask1Response({
    required this.introduction,
    required this.diagramData,
    required this.diagramDescription,
    required this.instruction,
  });

  factory WritingTask1Response.fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      'instruction',
      'introduction',
      'diagram_description',
      'diagram_data',
    ]);
    return WritingTask1Response(
      instruction: json['instruction'],
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

  const WritingTask2Response({
    required this.statement,
    required this.instruction,
  });

  factory WritingTask2Response.fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      'statement',
      'instruction',
    ]);
    return WritingTask2Response(
      statement: json['statement'],
      instruction: json['instruction'],
    );
  }
}

/// Response of evaluateTask1Answer.
class WritingEvaluationResponse {
  final double taskScore, coherenceScore, grammaticalScore, lexicalScore;
  final List<String> taskFeedback,
      coherenceFeedback,
      grammaticalFeedback,
      lexicalFeedback;

  const WritingEvaluationResponse({
    required this.taskScore,
    required this.coherenceScore,
    required this.grammaticalScore,
    required this.lexicalScore,
    required this.taskFeedback,
    required this.coherenceFeedback,
    required this.grammaticalFeedback,
    required this.lexicalFeedback,
  });

  /// Creaates WritingEvaluationResponse with the response of Task 1.
  factory WritingEvaluationResponse.fromTask1Json(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      "achievement_score",
      "achievement_feedback",
    ]);
    return _fromJson(
      json["achievement_score"],
      List<String>.from(json["achievement_feedback"]),
      json,
    );
  }

  /// Creaates WritingEvaluationResponse with the response of Task 2.
  factory WritingEvaluationResponse.fromTask2Json(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      "response_score",
      "response_feedback",
    ]);
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
    ApiResponseValidator.validateJsonResponse(json, [
      "coherence_score",
      "grammatical_score",
      "lexical_score",
      "coherence_feedback",
      "grammatical_feedback",
      "lexical_feedback",
    ]);
    return WritingEvaluationResponse(
      taskScore: taskScore,
      coherenceScore: json["coherence_score"],
      grammaticalScore: json["grammatical_score"],
      lexicalScore: json["lexical_score"],
      taskFeedback: taskFeedback,
      coherenceFeedback: List<String>.from(json["coherence_feedback"]),
      grammaticalFeedback: List<String>.from(json["grammatical_feedback"]),
      lexicalFeedback: List<String>.from(json["lexical_feedback"]),
    );
  }
}
