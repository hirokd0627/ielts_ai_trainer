import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
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
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderColor)),
        ),
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

  /// Called when a search word changes.
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

  TextStyle _headerTextStyle(bool active) {
    return active
        ? TextStyle(color: AppColors.textColor, fontWeight: FontWeight.w700)
        : TextStyle(
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w400,
          );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Search box
            if (widget.searchBarEnabled)
              Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.borderColor, width: 1),
                    bottom: BorderSide(color: AppColors.borderColor, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: AppStyles.textFieldStyle(context),
                        controller: _editingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                          hintText: 'Enter word to search...',
                          hintStyle: AppStyles.placeHolderText,
                          prefixIcon: Icon(Icons.search, size: 24),
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
                headingRowHeight: 45,
                headingRowColor: WidgetStatePropertyAll(Colors.white),
                border: TableBorder(
                  top: (widget.searchBarEnabled)
                      ? BorderSide.none
                      : BorderSide(color: AppColors.borderColor),
                  bottom: BorderSide(color: AppColors.borderColor),
                ),
                columns: [
                  DataColumn2(
                    size: ColumnSize.L,
                    isResizable: true,
                    label: Text(
                      'Prompt',
                      style: _headerTextStyle(_ctrl.sortColumnIndex == 0),
                    ),
                    onSort: _onSort,
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    isResizable: true,
                    label: Text(
                      'Date',
                      style: _headerTextStyle(_ctrl.sortColumnIndex == 1),
                    ),
                    onSort: _onSort,
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    isResizable: true,
                    label: Text(
                      'Task',
                      style: _headerTextStyle(_ctrl.sortColumnIndex == 2),
                    ),
                    onSort: _onSort,
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    isResizable: true,
                    label: Text(
                      'Topics',
                      style: _headerTextStyle(_ctrl.sortColumnIndex == 3),
                    ),
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

/// ViewModel that represents a UserAnswer for display on Question list.
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
