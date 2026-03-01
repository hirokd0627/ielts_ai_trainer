import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Ref. https://drift.simonbinder.eu/setup/#database-class

/// Application Database
@DriftDatabase(
  tables: [
    UserAnswersTable,
    WritingAnswerDetailsTable,
    PromptTopicsTable,
    SpeakingAnswerDetailsTable,
    SpeakingUtterancesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 8;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db',
      native: const DriftNativeOptions(
        // macos: Library/Containers/com.example.ieltsAiTrainer/Data/Documents/db.sql
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator m, int from, int to) async {
        // Recreate all tables if the schemaVersion changes.
        if (1 < to) {
          for (final table in allTables) {
            // Delete all tables and create ones.
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
      },
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

/// writing_answer_details
class WritingAnswerDetailsTable extends Table {
  @override
  String get tableName => 'writing_answer_details';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get userAnswerId => integer().references(UserAnswersTable, #id)();
  TextColumn get promptType => text().withLength(min: 1)();
  TextColumn get taskContext => text().withLength(min: 1)();
  TextColumn get taskInstruction => text().withLength(min: 1)();
  TextColumn get diagramDescription => text().nullable()();
  TextColumn get diagramFileUuid => text().nullable()();
  TextColumn get answerText => text().withLength(min: 1)();
  IntColumn get duration => integer()();
  // score and feedback are nullable because they will be updated after evaluation.
  RealColumn get taskScore => real().nullable()();
  RealColumn get coherenceScore => real().nullable()();
  RealColumn get lexicalScore => real().nullable()();
  RealColumn get grammaticalScore => real().nullable()();
  BoolColumn get isGraded => boolean().withDefault(Constant(false))();
  TextColumn get taskFeedback => text().nullable()();
  TextColumn get coherenceFeedback => text().nullable()();
  TextColumn get lexicalFeedback => text().nullable()();
  TextColumn get grammaticalFeedback => text().nullable()();
}

/// prompt_topics
class PromptTopicsTable extends Table {
  @override
  String get tableName => 'prompt_topics';

  IntColumn get userAnswerId => integer().references(UserAnswersTable, #id)();
  IntColumn get order => integer()();
  TextColumn get title => text().withLength(min: 1)();

  @override
  Set<Column> get primaryKey => {userAnswerId, order};
}

/// speaking_answer_details
class SpeakingAnswerDetailsTable extends Table {
  @override
  String get tableName => 'speaking_answer_details';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get userAnswerId => integer().references(UserAnswersTable, #id)();
  IntColumn get duration => integer()();
  // score and feedback are nullable because they will be updated after evaluation.
  RealColumn get coherenceScore => real().nullable()();
  RealColumn get lexicalScore => real().nullable()();
  RealColumn get grammaticalScore => real().nullable()();
  BoolColumn get isGraded => boolean()();
  TextColumn get coherenceFeedback => text().nullable()();
  TextColumn get lexicalFeedback => text().nullable()();
  TextColumn get grammaticalFeedback => text().nullable()();
  TextColumn get note => text().nullable()(); // used by only Part2
}

/// speaking_utterances
class SpeakingUtterancesTable extends Table {
  @override
  String get tableName => 'speaking_utterances';

  IntColumn get userAnswerId => integer().references(UserAnswersTable, #id)();
  IntColumn get order => integer()();
  BoolColumn get isUser => boolean()();
  BoolColumn get isGraded => boolean().withDefault(Constant(false))();
  TextColumn get message => text()();
  TextColumn get audioFileUuid => text().nullable()();
  // score is nullable because it will be updated after evaluation.
  RealColumn get pronunciationScore => real().nullable()();
  RealColumn get fluencyScore => real().nullable()();

  @override
  Set<Column> get primaryKey => {userAnswerId, order};
}
