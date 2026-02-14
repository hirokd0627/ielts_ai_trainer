import 'app_database.dart';

/// Seeding utilities for development
extension AppDatabaseDevSeed on AppDatabase {
  /// Erases all data for development initial state.
  Future<void> eraseAll() async {
    await delete(promptTopicsTable).go();
    await delete(writingAnswerDetailsTable).go();
    await delete(userAnswersTable).go();
  }
}
