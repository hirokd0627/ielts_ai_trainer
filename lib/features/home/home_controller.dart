import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/home/home_query_service.dart';
import 'package:ielts_ai_trainer/features/home/user_answer_vm.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:ielts_ai_trainer/shared/utils/datetime_utils.dart';
import 'package:table_calendar/table_calendar.dart';

/// Controller for Home screen
class HomeContoller {
  final HomeQueryService _querySrv;

  HomeContoller({required HomeQueryService queryService})
    : _querySrv = queryService;

  /// Returns true if there are any events in the month before the given year and month.
  Future<bool> hasUserAnswerBefore(int year, int month) async {
    final (y, m) = previousYearMonth(year, month);
    return await _querySrv.hasUserAnswerInMonth(y, m);
  }

  /// Returns true if there are any events in the month after the given year and month.
  Future<bool> hasUserAnswerAfter(int year, int month) async {
    final (y, m) = nextYearMonth(year, month);
    return await _querySrv.hasUserAnswerInMonth(y, m);
  }

  /// Returns events grouped by day for the given year and month.
  Future<LinkedHashMap<DateTime, List<UserAnswerVM>>> getDailyUserAnswerInMonth(
    int year,
    int month,
  ) async {
    final answers = await _querySrv.selectUserAnswersByMonth(year, month);

    // sort in ascending order
    answers.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final map = LinkedHashMap<DateTime, List<UserAnswerVM>>(
      equals: isSameDay,
      hashCode: (DateTime key) {
        return key.day * 1000000 + key.month * 10000 + key.year;
      },
    );
    for (final answer in answers) {
      final jst = answer.createdAt.toLocal();
      final key = DateTime(jst.year, jst.month, jst.day);
      map.putIfAbsent(key, () => []);
      map[key]!.add(answer);
    }

    return map;
  }

  /// Returns the date range covering the earliest and latest events.
  Future<DateTimeRange> getUserAnswerDateTimeRange() async {
    final range = await _querySrv
        .selectOldestAndLatestUserAnswerDateTimeRange();
    if (range == null) {
      final now = DateTime.now();
      return DateTimeRange(start: now, end: now);
    }
    return range;
  }

  /// Returns a list of QuestionListViewVM filtered by date, word, and limit.
  Future<List<QuestionListViewVM>> getAnswersByDateWord({
    DateTime? date,
    String word = '',
    int? limit,
  }) async {
    return await _querySrv.selectAnswersByDateWord(
      date: date,
      word: word,
      limit: limit,
    );
  }
}
