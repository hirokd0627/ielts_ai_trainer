import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_question_generator_screen.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

/// Speaking Topic 1 Question Generator Screen.
class SpeakingTopic1QuestionGeneratorScreen extends StatefulWidget {
  /// The prompt text to display initially, if set.
  final String? promptText;

  /// The topics to display initially, if set.
  final List<String>? topics;

  const SpeakingTopic1QuestionGeneratorScreen({
    super.key,
    this.promptText,
    this.topics,
  });

  @override
  State<SpeakingTopic1QuestionGeneratorScreen> createState() =>
      _SpeakingTopic1QuestionGeneratorScreenState();
}

/// State for SpeakingTopic1QuestionGeneratorScreen
class _SpeakingTopic1QuestionGeneratorScreenState
    extends State<SpeakingTopic1QuestionGeneratorScreen> {
  /// API service to generate prompt text
  final SpeakingApiService _apiSrv = SpeakingApiService();

  /// Called when the Generate button is tapped.
  /// Generates a prompt text using the given topics.
  /// Returns a record containing the generated prompt text and the topics used.
  Future<({List<String> topics, String promptText})> _generatePromptText(
    int topicCount,
    List<String> topics,
  ) async {
    final resp = await _apiSrv.generatePromptText(topicCount, topics);
    // TODO: error handling
    return (topics: resp.topics, promptText: resp.promptText);
  }

  /// Called when the Start button is tapped.
  void _onTappedStart(String promptText, List<String> topics) {
    // TODO: navigate to answer input screen
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: SpeakingQuestionGeneratorScreen(
        generatePromptText: _generatePromptText,
        onTappedStart: _onTappedStart,
        testTask: TestTask.speakingPart1,
        promptText: widget.promptText,
        topics: widget.topics,
      ),
    );
  }
}
