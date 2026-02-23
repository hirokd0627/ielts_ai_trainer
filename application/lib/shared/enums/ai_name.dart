/// AI name
enum AiName {
  chatGpt,
  gemini;

  /// Returns ai_name argument value to pass the API.
  String get aiNameArgmentValue {
    return switch (this) {
      AiName.chatGpt => 'chat_gpt',
      AiName.gemini => 'gemini',
    };
  }
}
