import 'package:ielts_ai_trainer/shared/enums/PronunciationEvaluationLanguage.dart';
import 'package:ielts_ai_trainer/shared/enums/ai_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Application Settings
class AppSettings {
  // Singleton
  static final AppSettings _instance = AppSettings();
  static AppSettings get instance => _instance;

  late final SharedPreferencesWithCache _prefs;

  /// Initialize.
  static Future<void> init() async {
    // Ref. https://pub.dev/packages/shared_preferences
    _instance._prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{'aiAgent', 'lang'},
      ),
    );
  }

  AiName get aiAgent {
    final name = _prefs.getString('aiAgent') ?? 'ChatGPT';
    return name == 'ChatGPT' ? AiName.chatGpt : AiName.gemini;
  }

  void setAiAgent(AiName value) {
    final name = value == AiName.chatGpt ? 'ChatGPT' : 'gemini';
    _prefs.setString('aiAgent', name);
  }

  PronunciationEvaluationLanguage get lang {
    final name = _prefs.getString('lang');
    return switch (name) {
      'en-GB' => PronunciationEvaluationLanguage.enGB,
      'en-AU' => PronunciationEvaluationLanguage.enAU,
      _ => PronunciationEvaluationLanguage.enUS,
    };
  }

  void setLang(PronunciationEvaluationLanguage value) {
    final lang = switch (value) {
      PronunciationEvaluationLanguage.enUS => 'en-US',
      PronunciationEvaluationLanguage.enAU => 'en-AU',
      PronunciationEvaluationLanguage.enGB => 'en-GB',
    };
    _prefs.setString('lang', lang);
  }
}
