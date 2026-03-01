import 'dart:convert';

import 'package:ielts_ai_trainer/shared/api/api_exception.dart';
import 'package:ielts_ai_trainer/shared/logging/logger.dart';

import 'package:http/http.dart' as http;

/// A mixin that validates ApiResonse.
mixin ApiResponseValidator {
  final _logger = createLogger('ApiResponseValidator');

  /// Validates response from Backend API.
  void validateApiResponse(http.Response resp) {
    if (resp.statusCode == 200) {
      return;
    }
    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    _logger.d('validateApiResponse', error: json);
    _throwException(resp, json);
  }

  /// Validates stream response from Backend API.
  Future<void> validateStreamApiResponse(http.StreamedResponse resp) async {
    if (resp.statusCode == 200) {
      return;
    }
    final body = await resp.stream.bytesToString();
    final json = jsonDecode(body) as Map<String, dynamic>;
    _logger.d('validateStreamApiResponse', error: json);
    _throwException(resp, json);
  }

  /// Validates keys in response JSON.
  static void validateJsonResponse(
    Map<String, dynamic> json,
    List<String> names,
  ) async {
    for (final name in names) {
      if (!json.containsKey(name)) {
        throw ApiException('Missing response element: $name');
      }
    }
  }

  /// Throws ApiException
  void _throwException(http.BaseResponse resp, Map<String, dynamic> json) {
    final message = json['error'] ?? 'Missing required key: error';
    throw ApiException(
      message,
      statusCode: resp.statusCode,
      uri: resp.request?.url,
    );
  }
}
