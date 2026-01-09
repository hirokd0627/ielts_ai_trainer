import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Ref. https://drift.simonbinder.eu/setup/#database-class

@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db',
      native: const DriftNativeOptions(
        // macos: Library/Containers/ielts_ai_trainer/Data/Library/com.example.ieltsAiTrainer/db.sql
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  /// query test
  Future<List<String>> queryTest() async {
    final result = await customSelect('''
  SELECT name
  FROM sqlite_schema
  WHERE type='table' AND name NOT LIKE 'sqlite_%';
      ''').get();

    return result.map((row) => row.read<String>('name')).toList();
  }
}
