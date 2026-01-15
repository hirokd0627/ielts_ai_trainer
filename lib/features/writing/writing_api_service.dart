import 'package:faker/faker.dart';

/// API service for Writing Task screens.
class WritingApiService {
  /// Generates a writing prompt text beased on the given topics.
  Future<WritingPromptResponse> generatePromptText(List<String> topics) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));
    return WritingPromptResponse(faker.lorem.sentences(3).join("\n"));
  }
}

/// Response for writing prompt generation.
class WritingPromptResponse {
  /// Generated prompt text.
  final String promptText;

  const WritingPromptResponse(this.promptText);
}
