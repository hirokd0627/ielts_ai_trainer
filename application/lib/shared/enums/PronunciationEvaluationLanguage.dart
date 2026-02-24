/// Language type for Pronunciation Evaluation.
enum PronunciationEvaluationLanguage {
  enUS,
  enAU,
  enGB;

  /// Returns lang argument value to pass the API.
  String get langArgmentValue {
    return switch (this) {
      PronunciationEvaluationLanguage.enUS => 'en-US',
      PronunciationEvaluationLanguage.enAU => 'en-AU',
      PronunciationEvaluationLanguage.enGB => 'en-GB',
    };
  }
}
