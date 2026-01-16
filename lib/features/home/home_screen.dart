import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/question_list/question_list_view.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';
import 'package:ielts_ai_trainer/features/home/calendar.dart';
import 'package:ielts_ai_trainer/features/home/home_controller.dart';
import 'package:ielts_ai_trainer/features/home/user_answer_vm.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';

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

  /// Whether _currentMonthEvents is loaded.
  bool _isLoaded = false;

  /// Events in the currently visible month of the calendar.
  LinkedHashMap<DateTime, List<UserAnswerVM>> _currentMonthEvents =
      LinkedHashMap<DateTime, List<UserAnswerVM>>();

  /// The selected date in the calendar
  DateTime? _selectedDate;

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

    setState(() {
      _calendarVisibleDateRange = dr;
      _selectedDate = _calendarVisibleDateRange.end;
      _currentMonthEvents = calEvents;
      _isLoaded = true;
    });
  }

  /// Called when a day is selected in calendar.
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  /// Called when day selections is cleared in calendar.
  void _onDaySelectionCleared() async {
    setState(() {
      _selectedDate = null;
    });
  }

  /// Called when a month is changed in calendar.
  void _onMonthChanged(int year, int month) async {
    final events = await _ctrl.getDailyUserAnswerInMonth(year, month);
    setState(() {
      _currentMonthEvents = events;
    });
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
                children: [HeadlineText('History')],
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
                  children: [HeadlineText("Solved Questions")],
                ),
                // Question list
                Expanded(
                  child: QuestionListView(
                    date: _selectedDate,
                    searchBarEnabled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
