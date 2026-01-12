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

    _rows = _questionListToDataRows(widget.eventList);
  }

  /// Updates the list when the parent widget gets the list.
  @override
  void didUpdateWidget(covariant QuestionListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.eventList != widget.eventList) {
      setState(() {
        _rows = _questionListToDataRows(widget.eventList);
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
          // TODO: format
          DataCell(Text(_displayDateFormat.format(item.datetime))),
          DataCell(Text(item.testTask.toString())),
          DataCell(Text(item.topics.toString())),
        ],
      );
    }).toList();
  }

  void _sort<T>(int columnIndex, bool ascending) {
    // TODO: implementtation
    // _rows._sort
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
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
          onSort: _sort,
        ),
        DataColumn2(
          size: ColumnSize.M,
          label: const Text('Date'),
          onSort: _sort,
        ),
        DataColumn2(
          size: ColumnSize.S,
          label: const Text('Task'),
          onSort: _sort,
        ),
        DataColumn2(
          size: ColumnSize.S,
          label: const Text('Topic'),
          onSort: _sort,
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
