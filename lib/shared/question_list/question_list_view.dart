import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:intl/intl.dart';

/// Widget that displayes a list of questions users have previously practiced.
class QuestionListView extends StatefulWidget {
  /// Items to be displayed in the list.
  final List<QuestionListViewVM> eventList;

  const QuestionListView({super.key, required this.eventList});

  @override
  State<QuestionListView> createState() => _QuestionListViewState();
}

/// State for QuestionListView
class _QuestionListViewState extends State<QuestionListView> {
  /// DateTime format: 'MMM d, yyyy', e.g., 'Jan 12, 2026'.
  final _displayDateFormat = DateFormat('MMM d, yyyy');

  // Fields for DataTable2
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  /// DataRows for DataTable2
  late List<DataRow> _rows;

  @override
  void initState() {
    super.initState();

    _rows = _questionListToDataRows(
      _sortList(_sortColumnIndex, _sortAscending),
    );
  }

  /// Updates the list when the parent widget gets the list.
  @override
  void didUpdateWidget(covariant QuestionListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.eventList != widget.eventList) {
      setState(() {
        _rows = _questionListToDataRows(
          _sortList(_sortColumnIndex, _sortAscending),
        );
      });
    }
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

    return widget.eventList;
  }

  /// Called when the column is tapped.
  void _onSort(int columnIndex, bool ascending) {
    final eventList = _sortList(columnIndex, ascending);

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _rows = _questionListToDataRows(eventList);
    });
  }

  /// Sorts items by prompt text.
  void _sortByPromptText(bool ascending) {
    widget.eventList.sort((a, b) {
      return ascending
          ? a.promptText.compareTo(b.promptText)
          : b.promptText.compareTo(a.promptText);
    });
  }

  /// Sorts items by created date.
  void _sortByDate(bool ascending) {
    widget.eventList.sort((a, b) {
      return ascending
          ? a.datetime.compareTo(b.datetime)
          : b.datetime.compareTo(a.datetime);
    });
  }

  /// Sorts items by test task.
  void _sortByTestTask(bool ascending) {
    widget.eventList.sort((a, b) {
      return ascending
          ? a.testTask.index.compareTo(b.testTask.index)
          : b.testTask.index.compareTo(a.testTask.index);
    });
  }

  /// Sorts items by topics.
  void _sortByTopics(bool ascending) {
    widget.eventList.sort((a, b) {
      return ascending
          ? a.topics.toString().compareTo(b.topics.toString())
          : b.topics.toString().compareTo(a.topics.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Uses PaginatedDataTable2 for the sticky header
    return DataTable2(
      // wrapInCard: false, // disable round border
      columns: [
        DataColumn2(
          size: ColumnSize.L,
          label: const Text('Prompt'),
          onSort: _onSort,
        ),
        DataColumn2(
          size: ColumnSize.M,
          label: const Text('Date'),
          onSort: _onSort,
        ),
        DataColumn2(
          size: ColumnSize.S,
          label: const Text('Task'),
          onSort: _onSort,
        ),
        DataColumn2(
          size: ColumnSize.S,
          label: const Text('Topics'),
          onSort: _onSort,
        ),
      ],
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      fixedTopRows: 1, // Set the sticky header
      isHorizontalScrollBarVisible: false,
      isVerticalScrollBarVisible: true,
      rows: _rows,
    );
  }
}

/// ViewModel representing a UserAnswer for display on Question list
class QuestionListViewVM {
  final String promptText;
  final TestTask testTask;
  final List<String> topics;
  final DateTime datetime;

  const QuestionListViewVM({
    required this.promptText,
    required this.testTask,
    required this.topics,
    required this.datetime,
  });
}
