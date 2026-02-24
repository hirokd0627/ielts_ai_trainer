import 'dart:convert';

import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';
import 'package:ielts_ai_trainer/shared/api/api_response_validator.dart';
import 'package:ielts_ai_trainer/shared/api/common_api_service.dart';
import 'package:ielts_ai_trainer/shared/domain/score_calculation_service.dart';
import 'package:ielts_ai_trainer/shared/enums/ai_name.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/http/api_requester.dart';
import 'package:http/http.dart' as http;

/// API service for the Speaking screens, generating prompts and evaluating answers.
class SpeakingApiService
    with ApiRequester, ApiResponseValidator, CommonApiService {
  /// Generates initial question of Part 1 and Part 3.
  Future<SpeakingQuestionResponse> generateInitialQuestion(
    int partNo,
    String topic,
    AiName aiName,
  ) async {
    return await _generateQuestion(partNo, topic: topic, aiName: aiName);
  }

  /// Generates subsequent question of Part 1 and Part 3 following the initial question.
  Future<SpeakingQuestionResponse> generateSubsequentQuestion(
    int partNo,
    String interactionId,
    String reply,
    AiName aiName,
  ) async {
    return await _generateQuestion(
      partNo,
      interactionId: interactionId,
      reply: reply,
      aiName: aiName,
    );
  }

  /// Generates Part2 cue card content.
  Future<SpeakingCuecardResponse> generatePart2CuecardContent(
    String topic,
    AiName aiName,
  ) async {
    final data = {'topic': topic, 'ai_name': aiName.aiNameArgmentValue};
    final respJson = await sendJsonPostRequest(
      'speaking/part2/generate-cuecard',
      data,
    );
    return SpeakingCuecardResponse.fromJson(respJson);
  }

  /// Generates question of Part 1 and Part 3.
  Future<SpeakingQuestionResponse> _generateQuestion(
    int partNo, {
    String? topic,
    String? reply,
    String? interactionId,
    required AiName aiName,
  }) async {
    if (partNo != 1 && partNo != 3) {
      throw ArgumentError('part must be between 1 or 3');
    }

    final data = {'ai_name': aiName.aiNameArgmentValue};
    final initial = topic != null;
    if (initial) {
      data['topic'] = topic;
    } else {
      data['prompt_id'] = interactionId!;
      data['reply'] = reply!;
    }
    final respJson = await sendJsonPostRequest(
      'speaking/part$partNo/generate-question',
      data,
    );
    return SpeakingQuestionResponse.fromJson(respJson);
  }

  /// Generates topic transition message for Part 1 and Part 3.
  Future<String> generateTopicTransitionMessage(String topic) async {
    final data = {'topic': topic};
    final respJson = await sendJsonPostRequest(
      'speaking/generate-transition-message',
      data,
    );
    return respJson['message'];
  }

  /// Generates closing message for Part 1 and Part 3.
  Future<String> generateClosingMessage(TestTask testTask) async {
    final data = {'part': testTask.number};
    final respJson = await sendJsonPostRequest(
      'speaking/generate-closing-message',
      data,
    );
    return respJson['message'];
  }

  /// Evaluates the given speaking chat answer.
  Future<SpeakingEvaluationResponse> evaluateChatAnswer({
    required SpeakingChatAnswer answer,
    required AiName aiName,
  }) async {
    // Creates arguments.
    final List<Map<String, String>> script = [];
    for (final u in answer.utterances) {
      final role = (u.isUser) ? 'examinee' : 'examiner';
      script.add({'role': role, 'message': u.text});
    }
    return await _evaluateAnswer(
      partNo: answer.testTask.number,
      script: script,
      aiName: aiName,
    );
  }

  /// Evaluates the given speaking speech answer.
  Future<SpeakingEvaluationResponse> evaluateSpeechAnswer({
    required SpeakingSpeechAnswer answer,
    required AiName aiName,
  }) async {
    final data = {
      'prompt': answer.prompt.text,
      'speech': answer.answer.text,
      'ai_name': aiName.aiNameArgmentValue,
    };
    final respJson = await sendJsonPostRequest('speaking/part2/evaluate', data);
    return SpeakingEvaluationResponse._fromJson(respJson);
  }

  /// Evaluates the pronunciation of speech audio data with script.
  Future<PronunciationEvaluationResponse> evaluatePronunciation({
    required String lang,
    required String audioFilePath,
    required String script,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      getUrl('speaking/evaluate-pronunciation'),
    );

    // Sets auth header.
    request.headers['X-API-KEY'] = ApiRequester.apiKey;

    // Sets script, language, and audio file.
    request.fields['lang'] = lang;
    request.fields['script'] = script;
    final audioFile = await http.MultipartFile.fromPath(
      'audio_data',
      audioFilePath,
    );
    request.files.add(audioFile);

    // Sends request through stream.
    final resp = await request.send();
    await validateStreamApiResponse(resp);

    final respBody = await resp.stream.bytesToString();

    return PronunciationEvaluationResponse._fromJson(
      jsonDecode(respBody) as Map<String, dynamic>,
    );
  }

  /// Evaluates the given speaking answer.
  Future<SpeakingEvaluationResponse> _evaluateAnswer({
    required int partNo,
    required List<Map<String, String>> script,
    required AiName aiName,
  }) async {
    final data = {'script': script, 'ai_name': aiName.aiNameArgmentValue};
    final respJson = await sendJsonPostRequest(
      'speaking/part$partNo/evaluate',
      data,
    );
    return SpeakingEvaluationResponse._fromJson(respJson);
  }
}

/// Response for topic generation.
class TopicResponse {
  /// Generated topics.
  final List<String> topics;

  TopicResponse({required this.topics});

  factory TopicResponse.fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, ['topics']);

    final topics = (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();
    return TopicResponse(topics: topics);
  }
}

/// Response of generateInitialQuestion and generateSubsequentQuestion.
class SpeakingQuestionResponse {
  /// Last ID object to identify the current conversation.
  final String interactionId;

  /// Generated question sentence.
  final String question;

  const SpeakingQuestionResponse({
    required this.interactionId,
    required this.question,
  });

  factory SpeakingQuestionResponse.fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, ['prompt_id', 'question']);
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

  const SpeakingCuecardResponse({required this.prompt});

  factory SpeakingCuecardResponse.fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      'instruction',
      'q1',
      'q2',
      'q3',
      'q4',
    ]);
    final prompt =
        '''
${json['instruction']}
    You should say:
        ${json['q1']}
        ${json['q2']}
        ${json['q3']}
and explain ${json['q4']}
''';

    return SpeakingCuecardResponse(prompt: prompt);
  }
}

/// Response of evaluate speaking answer.
class SpeakingEvaluationResponse {
  final double coherenceScore, lexicalScore, grammaticalScore;

  final List<String> coherenceFeedback, lexicalFeedback, grammaticalFeedback;

  const SpeakingEvaluationResponse({
    required this.coherenceScore,
    required this.lexicalScore,
    required this.grammaticalScore,
    required this.coherenceFeedback,
    required this.lexicalFeedback,
    required this.grammaticalFeedback,
  });

  static SpeakingEvaluationResponse _fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      'coherence_score',
      'lexical_score',
      'grammatical_score',
      'coherence_feedback',
      'lexical_feedback',
      'grammatical_feedback',
    ]);

    return SpeakingEvaluationResponse(
      coherenceScore: json["coherence_score"],
      grammaticalScore: json["grammatical_score"],
      lexicalScore: json["lexical_score"],
      coherenceFeedback: List<String>.from(json["coherence_feedback"]),
      grammaticalFeedback: List<String>.from(json["grammatical_feedback"]),
      lexicalFeedback: List<String>.from(json["lexical_feedback"]),
    );
  }
}

/// Response of evaluate pronunciation.
class PronunciationEvaluationResponse {
  final double fluencyScore;
  final double pronunciationScore;

  const PronunciationEvaluationResponse({
    required this.fluencyScore,
    required this.pronunciationScore,
  });

  static PronunciationEvaluationResponse _fromJson(Map<String, dynamic> json) {
    ApiResponseValidator.validateJsonResponse(json, [
      'fluency_score',
      'pronunciation_score',
    ]);

    return PronunciationEvaluationResponse(
      fluencyScore: to8Scale(json["fluency_score"]),
      pronunciationScore: to8Scale(json['pronunciation_score']),
    );
  }

  /// Converts 100-point scale to 0.0-8.0 scale.
  static double to8Scale(double score) {
    return ScoreCalculationService.roundToNearest(score * 8.0 / 100.0);
  }
}
