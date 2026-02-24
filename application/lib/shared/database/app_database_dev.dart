import 'package:drift/drift.dart';

import 'app_database.dart';

/// Database methods for development.
extension AppDatabaseDev on AppDatabase {
  /// Erases all data for development initial state.
  Future<void> eraseAll() async {
    await delete(promptTopicsTable).go();
    await delete(writingAnswerDetailsTable).go();
    await delete(userAnswersTable).go();
  }

  /// Set ungraded all.
  Future<void> ungradeAll() async {
    await update(
      writingAnswerDetailsTable,
    ).write(const WritingAnswerDetailsTableCompanion(isGraded: Value(false)));
    await update(
      speakingAnswerDetailsTable,
    ).write(const SpeakingAnswerDetailsTableCompanion(isGraded: Value(false)));
    await update(
      speakingUtterancesTable,
    ).write(const SpeakingUtterancesTableCompanion(isGraded: Value(false)));
  }
}
