import 'dart:convert';

import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// Common API service for the Speaking and Writing screens.
mixin TopicApiService on ApiRequester {
  /// Generates topics of Speaking parts.
  Future<List<String>> generateTopics(int count) async {
    final data = {'count': count};
    final dataJson = jsonEncode(data);
    final resp = await sendPostRequest('generate-topics', dataJson);
    final json = jsonDecode(resp.body) as Map<String, dynamic>;

    if (!json.containsKey('topics')) {
      throw FormatException('Missing response element: topics');
    }

    return (json['topics'] as List<dynamic>)
        .map((topic) => topic.toString())
        .toList();
  }
}
