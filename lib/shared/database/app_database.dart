import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Ref. https://drift.simonbinder.eu/setup/#database-class

/// Application Database
@DriftDatabase(tables: [UserAnswersTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db',
      native: const DriftNativeOptions(
        // databaseDirectory: getApplicationSupportDirectory,
        databaseDirectory: kDebugMode
            // macos: Library/Containers/com.example.ieltsAiTrainer/Data/Documents/db.sql
            ? getApplicationDocumentsDirectory
            // macos: Library/Containers/ielts_ai_trainer/Data/Library/com.example.ieltsAiTrainer/db.sql
            : getApplicationSupportDirectory,
      ),
    );
  }
}

/// user_answers table
class UserAnswersTable extends Table {
  @override
  String get tableName => 'user_answers';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get testTask => textEnum<TestTask>()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
