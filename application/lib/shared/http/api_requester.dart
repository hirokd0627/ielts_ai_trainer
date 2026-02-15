import 'package:http/http.dart' as http;

mixin ApiRequester {
  /// API key.
  static const String apiKey = String.fromEnvironment('API_KEY');

  /// API base URL.
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Returns API endpoint URI.
  Uri getUrl(String endpoint) {
    return Uri.parse('$_apiBaseUrl/$endpoint');
  }

  /// Send a POST request to the backend API.
  Future<http.Response> sendPostRequest(String endpoint, Object json) {
    return http.post(
      getUrl(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-KEY': apiKey,
      },
      body: json,
    );
  }
}
