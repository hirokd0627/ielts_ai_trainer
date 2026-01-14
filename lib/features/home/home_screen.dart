import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:provider/provider.dart';
import 'package:ielts_ai_trainer/features/home/calendar.dart';
import 'package:ielts_ai_trainer/features/home/home_controller.dart';
import 'package:ielts_ai_trainer/features/home/user_answer_vm.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:throttling/throttling.dart';

/// Home screen shown on app launch, displaying questions users have previously
/// practiced.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State for HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  /// Controller
  late final HomeContoller _ctrl;

  /// The date range currently visible in the calendar
  late final DateTimeRange _calendarVisibleDateRange;

  // Used to adjust the execution timing for searching questions.
  final _debounce = Debouncing<void>(
    duration: const Duration(milliseconds: 500),
  );

  /// TextEditingController for the search input field.
  final _editingController = TextEditingController();

  /// Whether _currentMonthEvents is loaded.
  bool _isLoaded = false;

  /// Events in the currently visible month of the calendar.
  LinkedHashMap<DateTime, List<UserAnswerVM>> _currentMonthEvents =
      LinkedHashMap<DateTime, List<UserAnswerVM>>();

  /// Events displayed in the QuestionListView.
  List<QuestionListViewVM> _questionListEvents = [];

  /// The selected date in the calendar
  DateTime? _selectedDate;

  /// The current search word
  String _searchWord = "";

  @override
  void initState() {
    super.initState();

    _ctrl = context.read<HomeContoller>();

    _loadInitialData();
  }

  /// Loads the initial data.
  Future<void> _loadInitialData() async {
    final dr = await _ctrl.getUserAnswerDateTimeRange();
    final calEvents = await _ctrl.getDailyUserAnswerInMonth(
      dr.end.year,
      dr.end.month,
    );
    final listEvents = await _getQuestionEventList(date: dr.end);

    setState(() {
      _calendarVisibleDateRange = dr;
      _selectedDate = _calendarVisibleDateRange.end;
      _currentMonthEvents = calEvents;
      _questionListEvents = listEvents;
      _isLoaded = true;
    });
  }

  /// Called when a day is selected in calendar.
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    final events = await _getQuestionEventList(
      date: selectedDay,
      word: _searchWord,
    );
    setState(() {
      _selectedDate = selectedDay;
      _questionListEvents = events;
    });
  }

  /// Called when day selections is cleared in calendar.
  void _onDaySelectionCleared() async {
    final eventList = await _getQuestionEventList(word: _searchWord);
    setState(() {
      _selectedDate = null;
      _questionListEvents = eventList;
    });
  }

  /// Called when a month is changed in calendar.
  void _onMonthChanged(int year, int month) async {
    final events = await _ctrl.getDailyUserAnswerInMonth(year, month);
    setState(() {
      _currentMonthEvents = events;
    });
  }

  /// Called when a search word is changed.
  Future<void> _onSearchWordChanged(String value) async {
    // Search questions a short time after search word is entered.
    final word = value.trim();
    _debounce.debounce(() async {
      final eventList = await _getQuestionEventList(
        date: _selectedDate,
        word: word,
      );
      setState(() {
        _searchWord = word;
        _questionListEvents = eventList;
      });
    });
  }

  /// Called when the search word clear botton is tapped.
  Future<void> _onSearchWordClearButtonPressed() async {
    _editingController.clear();
    final eventList = await _getQuestionEventList(date: _selectedDate);
    setState(() {
      _searchWord = "";
      _questionListEvents = eventList;
    });
  }

  /// Gets QuestionListViewVM based on selected date and search word.
  Future<List<QuestionListViewVM>> _getQuestionEventList({
    DateTime? date,
    String word = '',
  }) async {
    // Displays 20 events if date and word is empty
    final limit = (date == null && word.isEmpty) ? 20 : null;
    final eventList = await _ctrl.getAnswersByDateWord(
      date: date,
      word: word,
      limit: limit,
    );
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: Column(
        children: [
          Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              // Calendar
              if (_isLoaded)
                Calendar(
                  firstEventDay: _calendarVisibleDateRange.start,
                  lastEventDay: _calendarVisibleDateRange.end,
                  onDaySelected: _onDaySelected,
                  onDaySelectionCleared: _onDaySelectionCleared,
                  onMonthChanged: _onMonthChanged,
                  // Focuses on the most recent day with a user answer.
                  initialSelectedDate: _calendarVisibleDateRange.end,
                  currentMonthEvents: _currentMonthEvents,
                ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Solved Questions",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),

                // Search box
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
                      if (_searchWord.isNotEmpty)
                        IconButton(
                          onPressed: _onSearchWordClearButtonPressed,
                          icon: Icon(Icons.clear),
                        ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                // Question list
                Expanded(
                  child: QuestionListView(eventList: _questionListEvents),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
