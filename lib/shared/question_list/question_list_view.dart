import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_controller.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_query_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:throttling/throttling.dart';

/// Widget that displays a list of questions users have previously practiced.
class QuestionListView extends StatefulWidget {
  /// Controller for QuestionListView.
  final QuestionListController? controller;

  /// The date of the data to display.
  final DateTime? date;

  /// Whether the search bar is displayed.
  final bool searchBarEnabled;

  const QuestionListView({
    super.key,
    this.controller,
    this.date,
    this.searchBarEnabled = false,
  });

  @override
  State<QuestionListView> createState() => _QuestionListViewState();
}

/// State for QuestionListView.
class _QuestionListViewState extends State<QuestionListView> {
  /// TextEditingController for the search input field.
  final _editingController = TextEditingController();

  /// Controller for QuestionListView
  late final QuestionListController _ctrl;

  /// Whether _ctrl is created internal.
  late final bool _isInternalCtrl;

  /// Used to adjust the execution timing for searching questions.
  final _debounce = Debouncing<void>(
    duration: const Duration(milliseconds: 500),
  );

  _QuestionListViewState();

  /// Returns the data rows in the list.
  List<DataRow> get _questionListToDataRows {
    final displayDateFormat = DateFormat('MMM d, yyyy');
    return _ctrl.eventList.map((item) {
      return DataRow2(
        onTap: () => _onTappedRow(item),
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
          DataCell(Text(displayDateFormat.format(item.datetime))),
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

  @override
  void initState() {
    super.initState();

    /// Indicates whether the controller is created internally by this widget
    /// or passed from a parent widget.
    if (widget.controller != null) {
      _ctrl = widget.controller!;
      _isInternalCtrl = false;
    } else {
      _ctrl = QuestionListController(
        queryService: QuestionListQueryService(context.read<AppDatabase>()),
      );
      _isInternalCtrl = true;
    }

    _loadInitialData();
  }

  @override
  void dispose() {
    if (!_isInternalCtrl) {
      _ctrl.dispose();
    }
    _editingController.dispose();
    super.dispose();
  }

  /// Loads the initial data.
  Future<void> _loadInitialData() async {
    _ctrl.setSearchWord("");
    await _ctrl.refreshListRows();
  }

  /// Updates the list when the parent widget changes the date.
  @override
  void didUpdateWidget(covariant QuestionListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.date != widget.date) {
      _ctrl.setDate(widget.date, refreshList: true);
    }
  }

  /// Called when a column header is tapped.
  void _onSort(int columnIndex, bool ascending) {
    _ctrl.setOrder(columnIndex, ascending, refreshList: true);
  }

  /// Called when the search word clear botton is tapped.
  Future<void> _onSearchWordClearButtonPressed() async {
    _editingController.clear();
    _ctrl.setSearchWord("", refreshList: true);
  }

  /// Called when a search word is changed.
  Future<void> _onSearchWordChanged(String value) async {
    // Search questions a short time after search word is entered.
    _debounce.debounce(() async {
      _ctrl.setSearchWord(value.trim(), refreshList: true);
    });
  }

  /// Called when the row is tapped.
  void _onTappedRow(QuestionListViewVM row) {
    // Navigates to the result screen.
    final path = row.testTask == TestTask.writingTask1
        ? writingTask1ResultScreenRoutePath
        : writingTask2ResultScreenRoutePath;

    context.go(path, extra: RouterExtra({'id': row.id}));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Column(
          children: [
            // Search box
            if (widget.searchBarEnabled)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1),
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _editingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          hintText: 'Enter word to search...',
                          prefixIcon: Icon(Icons.search),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: _onSearchWordChanged,
                      ),
                    ),
                    SizedBox(width: 8),
                    if (_ctrl.searchWord.isNotEmpty)
                      IconButton(
                        onPressed: _onSearchWordClearButtonPressed,
                        icon: Icon(Icons.clear),
                      ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            Expanded(
              // Uses PaginatedDataTable2 for the sticky header
              child: DataTable2(
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
                sortColumnIndex: _ctrl.sortColumnIndex,
                sortAscending: _ctrl.sortAscending,
                fixedTopRows: 1, // Set the sticky header
                isHorizontalScrollBarVisible: false,
                isVerticalScrollBarVisible: true,
                rows: _questionListToDataRows,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// ViewModel representing a UserAnswer for display on Question list.
class QuestionListViewVM {
  final int id;
  final String promptText;
  final TestTask testTask;
  final List<String> topics;
  final DateTime datetime;

  const QuestionListViewVM({
    required this.id,
    required this.promptText,
    required this.testTask,
    required this.topics,
    required this.datetime,
  });
}
