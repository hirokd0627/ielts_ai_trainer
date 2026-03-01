import 'dart:convert';

import 'package:ielts_ai_trainer/shared/api/api_response_validator.dart';
import 'package:ielts_ai_trainer/shared/enums/ai_name.dart';
import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// Common API service for the Speaking and Writing screens.
mixin CommonApiService on ApiRequester, ApiResponseValidator {
  /// Generates topics of Speaking parts.
  Future<List<String>> generateTopics(
    int count,
    AiName aiName, {
    List<String>? excludeTopics,
  }) async {
    final data = {
      'count': count,
      'ai_name': aiName.aiNameArgmentValue,
      'exclude_topics': excludeTopics ?? [],
    };
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest('generate-topics', dataJson);
    validateApiResponse(resp);

    final json = jsonDecode(resp.body) as Map<String, dynamic>;

    if (!json.containsKey('topics')) {
      throw FormatException('Missing response element: topics');
    }

    return (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();
  }

  /// Sends post request with JSON body and receives JSON response body.
  Future<Map<String, dynamic>> sendJsonPostRequest(
    String endpoint,
    Object data,
  ) async {
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest(endpoint, dataJson);
    validateApiResponse(resp);
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }
}
