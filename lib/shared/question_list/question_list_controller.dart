import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:intl/intl.dart';

/// Controller for QuestionListView widget
class QuestionListController extends ChangeNotifier {
  /// DateTime format: 'MMM d, yyyy', e.g., 'Jan 12, 2026'.
  final _displayDateFormat = DateFormat('MMM d, yyyy');
  final QuestionListQueryService _querySrv;

  /// Events displayed in the QuestionListView.
  late List<QuestionListViewVM> _eventList;

  /// The current search word
  String _searchWord = '';

  /// DataRows for DataTable2
  List<DataRow> _rows = [];

  // Fields for DataTable2
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  /// The date of the data to display
  DateTime? _date;

  /// Returns the current search word
  String get searchWord {
    return _searchWord;
  }

  /// Returns the current sort column index
  int get sortColumnIndex {
    return _sortColumnIndex;
  }

  /// Returns the current sort ascending
  bool get sortAscending {
    return _sortAscending;
  }

  /// Returns the current list data for DataTable2
  List<DataRow> get rows {
    return _rows;
  }

  QuestionListController({required QuestionListQueryService queryService})
    : _querySrv = queryService;

  /// Sets the search word.
  ///
  /// Refreshes the list if refreshList is true.
  Future<void> setSearchWord(String word, {bool refreshList = false}) async {
    _searchWord = word;
    if (refreshList) {
      await _selectListRows();
    }
    notifyListeners();
  }

  /// Sets the date.
  ///
  /// Refreshes the list if refreshList is true.
  Future<void> setDate(DateTime? date, {bool refreshList = false}) async {
    _date = date;
    if (refreshList) {
      await _selectListRows();
    }
    notifyListeners();
  }

  /// Sets the list order.
  ///
  /// Refreshes the list if refreshList is true.
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

  /// Selects the list data based on current parameters.
  Future<void> _selectListRows() async {
    final events = await _getQuestionEventList();

    _eventList = events;
    _rows = _questionListToDataRows(
      _sortList(_sortColumnIndex, _sortAscending),
    );
    _eventList = events;
  }

  /// Returns a list of QuestionListViewVM filtered by date, word, and limit.
  Future<List<QuestionListViewVM>> _getAnswersByDateWord({int? limit}) async {
    return await _querySrv.selectAnswersByDateWord(
      date: _date,
      word: _searchWord,
      limit: limit,
    );
  }

  /// Converts a list of QuestionListViewVM into a list of DataRow for DataTable.
  List<DataRow> _questionListToDataRows(List<QuestionListViewVM> eventList) {
    return eventList.map((item) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              item.promptText.replaceAll('\n', ' '), // To one line
              maxLines: 1,
              // Fade to the right
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          DataCell(Text(_displayDateFormat.format(item.datetime))),
          DataCell(
            Text(switch (item.testTask) {
              TestTask.speakingPart1 => 'Speaking Part 1',
              TestTask.speakingPart2 => 'Speaking Part 2',
              TestTask.speakingPart3 => 'Speaking Part 3',
              TestTask.writingTask1 => 'Writing Task 1',
              TestTask.writingTask2 => 'Writing Task 2',
            }),
          ),
          DataCell(Text(item.topics.join(', '))),
        ],
      );
    }).toList();
  }

  /// Sorts items.
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

  /// Gets QuestionListViewVM based on selected date and search word.
  Future<List<QuestionListViewVM>> _getQuestionEventList() async {
    // Displays 20 events if date and word is empty
    final limit = (_date == null && _searchWord.isEmpty) ? 20 : null;
    final eventList = await _getAnswersByDateWord(limit: limit);
    return eventList;
  }
}
