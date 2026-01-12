import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/home/user_answer_vm.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:ielts_ai_trainer/shared/utils/datetime_utils.dart';

part 'home_query_service.g.dart';

/// Query service for Home screen, handling database data for display.
@DriftAccessor(tables: [UserAnswersTable, WritingAnswerDetailsTable])
class HomeQueryService extends DatabaseAccessor<AppDatabase>
    with _$HomeQueryServiceMixin {
  final QuestionListQueryService _questionListQuerySrv;

  HomeQueryService(super.attachedDatabase)
    : _questionListQuerySrv = QuestionListQueryService(attachedDatabase);

  /// Returns true if there are events in the given year and month.
  Future<bool> hasUserAnswerInMonth(int year, int month) async {
    final from = DateTime(year, month);
    final (toYear, toMonth) = nextYearMonth(year, month);
    final to = DateTime(toYear, toMonth);

    final query = selectOnly(userAnswersTable)
      ..addColumns([userAnswersTable.id.count()])
      ..where(
        userAnswersTable.createdAt.isBiggerOrEqualValue(from.toUtc()) &
            userAnswersTable.createdAt.isSmallerThanValue(to.toUtc()),
      );

    // execute
    final row = await query.getSingle();

    final count = row.read(userAnswersTable.id.count()) ?? 0;
    return count > 0;
  }

  /// Selects user-answers for the given year and month.
  Future<List<UserAnswerVM>> selectUserAnswersByMonth(
    int year,
    int month,
  ) async {
    final from = DateTime(year, month);
    final (toYear, toMonth) = nextYearMonth(year, month);
    final to = DateTime(toYear, toMonth);

    final query = select(userAnswersTable)
      ..where(
        (row) =>
            row.createdAt.isBiggerOrEqualValue(from.toUtc()) &
            row.createdAt.isSmallerThanValue(to.toUtc()),
      );

    return await _executeQuery(query);
  }

  /// Selects the date range covering the earliest and latest user-answers.
  Future<DateTimeRange?> selectOldestAndLatestUserAnswerDateTimeRange() async {
    final datetimes = <DateTime>[];

    for (final (_, order) in [OrderingMode.asc, OrderingMode.desc].indexed) {
      final row =
          await (select(userAnswersTable)
                ..orderBy([
                  (t) => OrderingTerm(expression: t.createdAt, mode: order),
                ])
                ..limit(1))
              .getSingleOrNull();
      if (row == null) {
        break;
      }
      datetimes.add(row.createdAt);
    }

    return datetimes.length == 2
        ? DateTimeRange(start: datetimes[0], end: datetimes[1])
        : null;
  }

  /// Selects user-answers for the given date, word, and limit.
  Future<List<QuestionListViewVM>> selectAnswersByDateWord({
    DateTime? date,
    String word = '',
    int? limit,
  }) async {
    return await _questionListQuerySrv.selectAnswersByDateWord(
      testTasks: TestTask.values.toSet(),
      date: date,
      word: word,
      limit: limit,
    );
  }

  /// Execute the given query.
  Future<List<UserAnswerVM>> _executeQuery(
    SimpleSelectStatement<$UserAnswersTableTable, UserAnswersTableData> query,
  ) async {
    // execute
    final rows = await query.get();

    return rows.map((row) {
      return UserAnswerVM(createdAt: row.createdAt);
    }).toList();
  }
}
