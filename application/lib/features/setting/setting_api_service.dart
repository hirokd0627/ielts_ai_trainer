import 'dart:convert';

import 'package:ielts_ai_trainer/shared/http/api_requester.dart';

/// API service for Setting screen.
class SettingApiService with ApiRequester {
  /// Returns API availability status.
  Future<StatusResponse> getApiStatus() async {
    final resp = await sendGetRequest('setting/api-status');
    return StatusResponse.fromJson(
      jsonDecode(resp.body) as Map<String, dynamic>,
    );
  }
}

/// Response of getApiStatus.
class StatusResponse {
  /// ChatGPT availability status.
  final String chatGPTStatus;

  /// Gemini availability status.
  final String geminiStatus;

  const StatusResponse({
    required this.chatGPTStatus,
    required this.geminiStatus,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    for (var name in ['chat_gpt_status', 'gemini_status']) {
      if (!json.containsKey(name)) {
        throw Exception('Missing required key: $name');
      }
    }

    return StatusResponse(
      chatGPTStatus: json['chat_gpt_status'],
      geminiStatus: json['gemini_status'],
    );
  }
}
