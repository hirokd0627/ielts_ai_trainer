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
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db2',
      native: const DriftNativeOptions(
        // macos: Library/Containers/com.example.ieltsAiTrainer/Data/Documents/db.sql
        databaseDirectory: getApplicationDocumentsDirectory,
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

/// writing_answer_details
class WritingAnswerDetailsTable extends Table {
  @override
  String get tableName => 'writing_answer_details';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get userAnswerId => integer().references(UserAnswersTable, #id)();
  TextColumn get promptType => text().withLength(min: 1)();
  TextColumn get promptText => text().withLength(min: 1)();
  TextColumn get answerText => text().withLength(min: 1)();
  IntColumn get duration => integer()();
  // score and feedback are nullable because they will be updated after evaluation.
  RealColumn get score => real().nullable()();
  RealColumn get achievementScore => real().nullable()();
  RealColumn get coherenceScore => real().nullable()();
  RealColumn get lexialScore => real().nullable()();
  RealColumn get grammaticalScore => real().nullable()();
  BoolColumn get isGraded => boolean()();
  TextColumn get feedback => text().nullable()();
  // creation date is the same as the parent UserAnswer
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
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
  RealColumn get score => real().nullable()();
  RealColumn get coherenceScore => real().nullable()();
  RealColumn get lexialScore => real().nullable()();
  RealColumn get grammaticalScore => real().nullable()();
  RealColumn get fluencyScore => real().nullable()();
  BoolColumn get isGraded => boolean()();
  TextColumn get feedback => text().nullable()();
  TextColumn get note => text().nullable()(); // used by only Part2
  // creation date is the same as the parent UserAnswer
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// speaking_utterances
class SpeakingUtterancesTable extends Table {
  @override
  String get tableName => 'speaking_utterances';

  IntColumn get userAnswerId => integer().references(UserAnswersTable, #id)();
  IntColumn get order => integer()();
  BoolColumn get isUser => boolean()();
  TextColumn get message => text()();
  TextColumn get audioFileUuid => text().nullable()();
  // score is nullable because it will be updated after evaluation.
  RealColumn get fluencyScore => real().nullable()();
  // creation date is the same as the parent UserAnswer
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userAnswerId, order};
}
