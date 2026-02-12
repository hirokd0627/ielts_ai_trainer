import 'package:http/http.dart' as http;

mixin ApiRequester {
  /// API key.
  static const String _apiKey = String.fromEnvironment('API_KEY');

  /// API base URL.
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Send a POST request to the backend API.
  Future<http.Response> sendPostRequest(String endpoint, Object json) {
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
