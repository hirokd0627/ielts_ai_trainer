import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';

/// Controller for QuestionListView widget.
class QuestionListController extends ChangeNotifier {
  /// Query service for QuestionList.
  final QuestionListQueryService _querySrv;

  /// The TestTask of the data to display.
  final TestTask? _testTask;

  /// The events displayed in the QuestionListView.
  List<QuestionListViewVM> _eventList = [];

  /// The current search word.
  String _searchWord = '';

  // Fields for DataTable2.
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  /// The date of the data to display.
  DateTime? _date;

  String get searchWord {
    return _searchWord;
  }

  int get sortColumnIndex {
    return _sortColumnIndex;
  }

  bool get sortAscending {
    return _sortAscending;
  }

  List<QuestionListViewVM> get eventList {
    return _eventList;
  }

  QuestionListController({
    required QuestionListQueryService queryService,
    TestTask? testTask,
  }) : _querySrv = queryService,
       _testTask = testTask;

  /// Sets the search word and optionally refreshes the list.
  Future<void> setSearchWord(String word, {bool refreshList = false}) async {
    _searchWord = word;
    if (refreshList) {
      await _selectListRows();
    }
    notifyListeners();
  }

  /// Sets the date and optionally refreshes the list.
  Future<void> setDate(DateTime? date, {bool refreshList = false}) async {
    _date = date;
    if (refreshList) {
      await _selectListRows();
    }
    notifyListeners();
  }

  /// Sets the list order and optionally refreshes the list.
  Future<void> setOrder(
    int columnIndex,
    bool asc, {
    bool refreshList = false,
  }) async {
    _sortColumnIndex = columnIndex;
    _sortAscending = asc;
    if (refreshList) {
      await _selectListRows();
    }
    notifyListeners();
  }

  /// Refresh the list data based on current parameters with notifying.
  Future<void> refreshListRows() async {
    await _selectListRows();
    notifyListeners();
  }

  /// Selects the list data based on current search word, date, and sort order.
  Future<void> _selectListRows() async {
    final events = await _getAnswersByDateWord();

    _eventList = events;
    _sortList(_sortColumnIndex, _sortAscending);
  }

  /// Returns a list of QuestionListViewVM filtered by date, word, and limit.
  Future<List<QuestionListViewVM>> _getAnswersByDateWord() async {
    // Displays 20 events if date and word is empty
    final limit = (_date == null && _searchWord.isEmpty) ? 20 : null;
    return await _querySrv.selectAnswersByDateWord(
      testTasks: _testTask != null ? {_testTask} : null,
      date: _date,
      word: _searchWord,
      limit: limit,
    );
  }

  /// Sorts the items.
  List<QuestionListViewVM> _sortList(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      _sortByPromptText(ascending);
    } else if (columnIndex == 1) {
      _sortByDate(ascending);
    } else if (columnIndex == 2) {
      _sortByTestTask(ascending);
    } else if (columnIndex == 3) {
      _sortByTopics(ascending);
    }

    return _eventList;
  }

  /// Sorts items by prompt text.
  void _sortByPromptText(bool ascending) {
    _eventList.sort((a, b) {
      return ascending
          ? a.promptText.compareTo(b.promptText)
          : b.promptText.compareTo(a.promptText);
    });
  }

  /// Sorts items by created date.
  void _sortByDate(bool ascending) {
    _eventList.sort((a, b) {
      return ascending
          ? a.datetime.compareTo(b.datetime)
          : b.datetime.compareTo(a.datetime);
    });
  }

  /// Sorts items by test task.
  void _sortByTestTask(bool ascending) {
    _eventList.sort((a, b) {
      return ascending
          ? a.testTask.index.compareTo(b.testTask.index)
          : b.testTask.index.compareTo(a.testTask.index);
    });
  }

  /// Sorts items by topics.
  void _sortByTopics(bool ascending) {
    _eventList.sort((a, b) {
      return ascending
          ? a.topics.toString().compareTo(b.topics.toString())
          : b.topics.toString().compareTo(a.topics.toString());
    });
  }
}
