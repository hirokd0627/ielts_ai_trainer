import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

import 'app_database.dart';

/// Seeding utilities for development
extension AppDatabaseDevSeed on AppDatabase {
  /// Erases all data for development initial state.
  Future<void> eraseAll() async {
    await delete(promptTopicsTable).go();
    await delete(writingAnswerDetailsTable).go();
    await delete(userAnswersTable).go();
  }

  /// Resets all data for development initial state.
  Future<void> resetToDevelopmentData() async {
    await eraseAll();
    await addWritingTask1AnswerDetail();
  }

  Future<List<Map<String, dynamic>>> _loadJson() async {
    final jsonStr = await rootBundle.loadString(
      'assets_dev/seeds/test_100.json',
    );
    final List<dynamic> data = json.decode(jsonStr);
    return data.cast<Map<String, dynamic>>();
  }

  Future<void> addWritingTask1AnswerDetail() async {
    List<Map<String, dynamic>> jsonData = await _loadJson();

    for (final data in jsonData) {
      _addWritingTask1HisotryDetail(
        promptText: data['promptText'],
        answerText: data['answerText'],
        achievementScore: data['achievementScore'],
        coherenceScore: data['coherenceScore'],
        lexialScore: data['lexialScore'],
        grammaticalScore: data['grammaticalScore'],
        duration: data['duration'],
        feedback: data['feedback'],
        isGraded: true,
        topics: (data['topics'] as List).cast<String>(),
        createdAt: DateTime.parse(data['createdAt']),
      );
    }
  }

  /// Insert WritingAnswerDetail for Task 1 with associated UserAnswer
  Future<int> _addWritingTask1HisotryDetail({
    required String promptText,
    required String answerText,
    required double achievementScore,
    required double coherenceScore,
    required double lexialScore,
    required double grammaticalScore,
    required String feedback,
    required bool isGraded,
    required int duration,
    required List<String> topics,
    required DateTime createdAt,
  }) {
    return transaction<int>(() async {
      // UserAnswer
      final uphId = await into(userAnswersTable).insert(
        UserAnswersTableCompanion(
          testTask: Value(TestTask.writingTask1),
          createdAt: Value(createdAt),
        ),
      );

      // WritingAnswerDetails for Task 1
      final score =
          (achievementScore + coherenceScore + lexialScore + grammaticalScore) /
          4.0;
      final dtId = await into(writingAnswerDetailsTable).insert(
        WritingAnswerDetailsTableCompanion(
          userAnswer: Value(uphId),
          promptText: Value(promptText),
          answerText: Value(answerText),
          score: Value(score),
          achievementScore: Value(achievementScore),
          coherenceScore: Value(coherenceScore),
          lexialScore: Value(lexialScore),
          grammaticalScore: Value(grammaticalScore),
          duration: Value(duration),
          feedback: Value(feedback),
          isGraded: Value(isGraded),
        ),
      );

      // PromptTopics
      for (int i = 0; i < topics.length; i++) {
        await into(promptTopicsTable).insert(
          PromptTopicsTableCompanion(
            userAnswer: Value(uphId),
            order: Value(i + 1), // 1-base
            title: Value(topics[i]),
          ),
        );
      }

      return dtId;
    });
  }
}
