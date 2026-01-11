import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

import 'app_database.dart';

/// Seeding utilities for development
extension AppDatabaseDevSeed on AppDatabase {
  /// Reset all data for development initial state
  Future<void> resetToDevelopmentData() async {
    await delete(userAnswersTable).go();
    await addUserAnswers();
  }

  /// Inserts user_answers rows
  Future<void> addUserAnswers() async {
    List<Map<String, dynamic>> jsonData = await _loadJson();
    for (final data in jsonData) {
      _addUserAnswers(
        testTask: TestTask.values.byName(data['testTask']),
        createdAt: DateTime.parse(data['createdAt']),
      );
    }
  }

  Future<List<Map<String, dynamic>>> _loadJson() async {
    final jsonStr = await rootBundle.loadString(
      'assets_dev/seeds/test_100.json',
    );
    final List<dynamic> data = json.decode(jsonStr);
    return data.cast<Map<String, dynamic>>();
  }

  Future<int> _addUserAnswers({
    required TestTask testTask,
    required DateTime createdAt,
  }) async {
    return await into(userAnswersTable).insert(
      UserAnswersTableCompanion(
        testTask: Value(testTask),
        createdAt: Value(createdAt),
      ),
    );
  }
}
