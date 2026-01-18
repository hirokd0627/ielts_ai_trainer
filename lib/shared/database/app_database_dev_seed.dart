import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

import 'app_database.dart';

final _seedJsonKey = 'assets_dev/seeds/test_10.json';

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
    await addWritingAnswerDetail();
  }

  Future<List<Map<String, dynamic>>> _loadJson() async {
    final jsonStr = await rootBundle.loadString(_seedJsonKey);
    final List<dynamic> data = json.decode(jsonStr);
    return data.cast<Map<String, dynamic>>();
  }

  Future<void> addWritingAnswerDetail() async {
    List<Map<String, dynamic>> jsonData = await _loadJson();

    for (final data in jsonData) {
      final testTask = data['testTask'] == 'w1'
          ? TestTask.writingTask1
          : TestTask.writingTask2;

      _addWritingAnswerDetail(
        promptText: data['promptText'],
        promptType: data['promptType'],
        answerText: data['answerText'],
        // achievementScore: data['achievementScore'],
        // coherenceScore: data['coherenceScore'],
        // lexialScore: data['lexialScore'],
        // grammaticalScore: data['grammaticalScore'],
        duration: data['duration'],
        feedback: data['feedback'],
        isGraded: false,
        topics: (data['topics'] as List).cast<String>(),
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['createdAt']),
        testTask: testTask,
      );
    }
  }

  /// Insert WritingAnswerDetail for Task 1 with associated UserAnswer
  Future<int> _addWritingAnswerDetail({
    required String promptText,
    required String promptType,
    required String answerText,
    double? achievementScore,
    double? coherenceScore,
    double? lexialScore,
    double? grammaticalScore,
    required String feedback,
    required bool isGraded,
    required int duration,
    required List<String> topics,
    required DateTime createdAt,
    required DateTime updatedAt,
    required TestTask testTask,
  }) {
    return transaction<int>(() async {
      // UserAnswer
      final uphId = await into(userAnswersTable).insert(
        UserAnswersTableCompanion(
          testTask: Value(testTask),
          createdAt: Value(createdAt),
        ),
      );

      // WritingAnswerDetails for Task 1
      final score =
          (achievementScore != null &&
              coherenceScore != null &&
              lexialScore != null &&
              grammaticalScore != null)
          ? (achievementScore +
                    coherenceScore +
                    lexialScore +
                    grammaticalScore) /
                4.0
          : null;
      final dtId = await into(writingAnswerDetailsTable).insert(
        WritingAnswerDetailsTableCompanion(
          userAnswerId: Value(uphId),
          promptType: Value(promptType),
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
          updatedAt: Value(createdAt),
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
