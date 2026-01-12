import 'package:drift/drift.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';

part 'question_list_query_service.g.dart';

/// Query service for QuestionListView, handling database data for display.
@DriftAccessor(tables: [UserAnswersTable, WritingAnswerDetailsTable])
class QuestionListQueryService extends DatabaseAccessor<AppDatabase>
    with _$QuestionListQueryServiceMixin {
  List<Join<HasResultSet, dynamic>> get detailTableJoins {
    return [
      leftOuterJoin(
        writingAnswerDetailsTable,
        writingAnswerDetailsTable.userAnswer.equalsExp(userAnswersTable.id),
      ),
      // TODO: speaking
    ];
  }

  QuestionListQueryService(super.attachedDatabase);

  /// Selects answer histories filtered by test tasks, date, search word, and limit.
  Future<List<QuestionListViewVM>> selectAnswersByDateWord({
    Set<TestTask>? testTasks,
    DateTime? date,
    String word = '',
    int? limit,
  }) async {
    testTasks ??= TestTask.values.toSet();

    // Join
    final joins = <Join<HasResultSet, dynamic>>[];
    if (testTasks.contains(TestTask.writingTask1) ||
        testTasks.contains(TestTask.writingTask2)) {
      joins.add(
        leftOuterJoin(
          writingAnswerDetailsTable,
          writingAnswerDetailsTable.userAnswer.equalsExp(userAnswersTable.id),
        ),
      );
    }
    if (testTasks.contains(TestTask.speakingPart1) ||
        testTasks.contains(TestTask.speakingPart2) ||
        testTasks.contains(TestTask.speakingPart3)) {
      // TODO: speaking
    }

    final joinedQuery = select(userAnswersTable).join(joins);

    // Where
    if (date != null) {
      final from = DateTime(date.year, date.month, date.day);
      final to = from.add(const Duration(days: 1));
      joinedQuery.where(
        userAnswersTable.createdAt.isBiggerOrEqualValue(from.toUtc()) &
            userAnswersTable.createdAt.isSmallerThanValue(to.toUtc()),
      );
    }

    final wordWhereClauses = <Expression<bool>>[];
    if (word.isNotEmpty) {
      if (testTasks.contains(TestTask.writingTask1) ||
          testTasks.contains(TestTask.writingTask2)) {
        wordWhereClauses.add(
          writingAnswerDetailsTable.promptText.contains(word),
        );
      }
      if (testTasks.contains(TestTask.speakingPart1) ||
          testTasks.contains(TestTask.speakingPart2) ||
          testTasks.contains(TestTask.speakingPart3)) {
        // TODO: speaking
      }

      joinedQuery.where(wordWhereClauses.reduce((a, b) => a | b));
    }

    // limit
    if (limit != null) {
      joinedQuery.limit(limit);
    }

    // execute
    final rows = await joinedQuery.map((row) {
      return {
        'userAnswers': row.readTable(userAnswersTable),
        'writingAnswerDetails': row.readTableOrNull(writingAnswerDetailsTable),

        // TODO: speaking
      };
    }).get();

    final userAnswers = rows.map((row) {
      final ua = row['userAnswers'] as UserAnswersTableData;
      final wa = row['writingAnswerDetails'] as WritingAnswerDetailsTableData;
      return QuestionListViewVM(
        promptText: wa.promptText,
        testTask: ua.testTask,
        // TODO: topics from DB
        topics: ["topic a", "topic b", "topic c"],
        datetime: ua.createdAt,
      );
    }).toList();

    return userAnswers;
  }
}
