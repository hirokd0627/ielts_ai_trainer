import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';

part 'question_list_query_service.g.dart';

/// Query service for QuestionListView, handling database data retrieval.
@DriftAccessor(
  tables: [UserAnswersTable, WritingAnswerDetailsTable, PromptTopicsTable],
)
class QuestionListQueryService extends DatabaseAccessor<AppDatabase>
    with _$QuestionListQueryServiceMixin {
  QuestionListQueryService(super.attachedDatabase);

  /// Selects answer histories, optionally filtered by test tasks, date,
  /// search word, and limiting the results.
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
          writingAnswerDetailsTable.userAnswerId.equalsExp(userAnswersTable.id),
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
      final from = DateTime(date.year, date.month, date.day).toUtc();
      final to = from.add(const Duration(days: 1));
      joinedQuery.where(
        userAnswersTable.createdAt.isBiggerOrEqualValue(from) &
            userAnswersTable.createdAt.isSmallerThanValue(to),
      );
    }

    // Test Task
    if (testTasks.isNotEmpty &&
        !setEquals(testTasks, Set.from(TestTask.values))) {
      final testTaskWhereClauses = <Expression<bool>>[];
      for (final testTask in TestTask.values) {
        if (testTasks.contains(testTask)) {
          testTaskWhereClauses.add(
            userAnswersTable.testTask.equalsValue(testTask),
          );
        }
      }
      joinedQuery.where(testTaskWhereClauses.reduce((a, b) => a | b));
    }

    // Search word
    if (word.isNotEmpty) {
      final wordWhereClauses = <Expression<bool>>[];
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
      if (wordWhereClauses.isNotEmpty) {
        joinedQuery.where(wordWhereClauses.reduce((a, b) => a | b));
      }
    }

    // limit
    if (limit != null) {
      joinedQuery.limit(limit);
    }

    // order
    joinedQuery.orderBy([OrderingTerm.asc(userAnswersTable.id)]);

    // UserAnswers and Details
    final userAnswerRows = await joinedQuery.get();
    if (userAnswerRows.isEmpty) {
      return [];
    }

    // Topics
    final userAnswerIds = userAnswerRows
        .map((row) => row.readTable(userAnswersTable).id)
        .toList();
    final topicsRows =
        await (select(promptTopicsTable)
              ..where((t) => t.userAnswer.isIn(userAnswerIds))
              ..orderBy([
                (t) => OrderingTerm.asc(t.userAnswer),
                (t) => OrderingTerm.asc(t.order),
              ]))
            .get();
    final topicsMap = <int, List<String>>{};
    for (final row in topicsRows) {
      topicsMap.putIfAbsent(row.userAnswer, () => []).add(row.title);
    }

    /// Converts a database query row into a QuestionListViewVM.
    final userAnswers = <QuestionListViewVM>[];
    for (final row in userAnswerRows) {
      final ua = row.readTable(userAnswersTable);
      final wa = row.readTableOrNull(writingAnswerDetailsTable);

      userAnswers.add(
        QuestionListViewVM(
          id: ua.id,
          promptText: wa?.promptText ?? '',
          testTask: ua.testTask,
          datetime: ua.createdAt.toLocal(),
          topics: topicsMap[ua.id] ?? [],
        ),
      );
    }

    return userAnswers;
  }
}
