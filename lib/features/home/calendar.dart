import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';
import 'package:ielts_ai_trainer/features/home/user_answer_vm.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ielts_ai_trainer/shared/utils/datetime_utils.dart';

/// Calendar displays marks on days user practiced
class Calendar extends StatefulWidget {
  /// The first selectable year-month
  final DateTime firstEventDay;

  /// The last selectable year-month
  final DateTime lastEventDay;

  /// The initially selected date
  final DateTime initialSelectedDate;

  /// Events in current displayed month
  final Map<DateTime, List<UserAnswerVM>> currentMonthEvents;

  /// Called when a day is selected.
  final OnDaySelected onDaySelected;

  /// Called when day selections is cleared.
  final void Function() onDaySelectionCleared;

  /// Called when a month is changed.
  final void Function(int nextYear, int nextMonth) onMonthChanged;

  const Calendar({
    super.key,
    required this.firstEventDay,
    required this.lastEventDay,
    required this.onDaySelected,
    required this.onDaySelectionCleared,
    required this.initialSelectedDate,
    required this.currentMonthEvents,
    required this.onMonthChanged,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

/// State for Calendar
class _CalendarState extends State<Calendar> {
  /// Current displayed Year and Month
  late DateTime _focusedDate;

  /// Current selected date
  late DateTime? _selectedDate;

  /// The fist day that can be tapped
  late DateTime _tappableFirstDay;

  /// The last day that can be tapped
  late DateTime _tappableLastDay;

  // Whether navigation to the previous month is enabled.
  bool _canMovePreviousMonth = true;

  // Whether navigation to the next month is enabled.
  bool _canMoveNextMonth = true;

  @override
  void initState() {
    super.initState();

    // Set firstDay to the 1st day and lastDay to the last day so that
    // clicks on all displayed days can be detected.
    final (firstY, firstM) = previousYearMonth(
      widget.firstEventDay.year,
      widget.firstEventDay.month,
    );
    _tappableFirstDay = DateTime(firstY, firstM, 1);
    final (lastY, lastM) = nextYearMonth(
      widget.lastEventDay.year,
      widget.lastEventDay.month,
    );
    _tappableLastDay = DateTime(lastY, lastM, lastDayOfMonth(lastY, lastM));

    _focusedDate = widget.initialSelectedDate;
    _selectedDate = widget.initialSelectedDate;

    _updateCalendarMonthChangeButtonState();
  }

  /// Updates the list when the parent widget changes the date.
  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    final rangeChanged =
        (oldWidget.firstEventDay != widget.firstEventDay ||
        oldWidget.lastEventDay != widget.lastEventDay);
    final currentMonthChanged =
        oldWidget.currentMonthEvents != widget.currentMonthEvents;

    if (rangeChanged || currentMonthChanged) {
      final (firstY, firstM) = previousYearMonth(
        widget.firstEventDay.year,
        widget.firstEventDay.month,
      );
      final (lastY, lastM) = nextYearMonth(
        widget.lastEventDay.year,
        widget.lastEventDay.month,
      );

      setState(() {
        _tappableFirstDay = DateTime(firstY, firstM, 1);
        _tappableLastDay = DateTime(lastY, lastM, lastDayOfMonth(lastY, lastM));
        _updateCalendarMonthChangeButtonState();
      });
    }
  }

  /// Returns true if there are events on the given day.
  bool _isDayEnabled(DateTime day) {
    return widget.currentMonthEvents.containsKey(
      DateTime(day.year, day.month, day.day),
    );
  }

  /// Called when a day is selected.
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final dt = _isDayEnabled(selectedDay) ? selectedDay : null;

    setState(() {
      _selectedDate = dt;
      _focusedDate = focusedDay;
    });

    if (dt != null) {
      widget.onDaySelected.call(selectedDay, focusedDay);
    } else {
      widget.onDaySelectionCleared.call();
    }
  }

  // Clamp datetime between event date range.
  DateTime _clampDate(DateTime date) {
    var focusedDate = date;
    if (focusedDate.isBefore(widget.firstEventDay)) {
      focusedDate = widget.firstEventDay;
    } else if (focusedDate.isAfter(widget.lastEventDay)) {
      focusedDate = widget.lastEventDay;
    }
    return focusedDate;
  }

  /// Handles the event when the selected month is changed.
  ///
  /// If next is true, moves to the next month. otherwise, moves to the previous month.
  void _onPressedMonthChange(bool next) {
    final (y, m) = next
        ? nextYearMonth(_focusedDate.year, _focusedDate.month)
        : previousYearMonth(_focusedDate.year, _focusedDate.month);

    // Clamp datetime between event date range.
    final nextFocusedDate = _clampDate(DateTime(y, m));

    setState(() {
      // Slide page
      _focusedDate = nextFocusedDate;

      // Update calendar month change button state
      _updateCalendarMonthChangeButtonState();
    });

    return widget.onMonthChanged.call(
      nextFocusedDate.year,
      nextFocusedDate.month,
    );
  }

  /// Updates the enabled state of the calendar month change buttons.
  void _updateCalendarMonthChangeButtonState() {
    final focusedYearMonth = DateTime(_focusedDate.year, _focusedDate.month);
    final firstYearMonth = DateTime(
      widget.firstEventDay.year,
      widget.firstEventDay.month,
    );
    final lastYearMonth = DateTime(
      widget.lastEventDay.year,
      widget.lastEventDay.month,
    );
    _canMovePreviousMonth = focusedYearMonth.isAfter(firstYearMonth);
    _canMoveNextMonth = focusedYearMonth.isBefore(lastYearMonth);
  }

  // MarkerBuilder function for calendar.
  Widget? _markerBuilder(_, DateTime day, _) {
    final markerStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    );
    // Displays marks in days that have events.
    final date = DateTime(day.year, day.month, day.day);
    final events = widget.currentMonthEvents[date];
    if (events == null || events.isEmpty) {
      return null;
    }
    final marker = <Widget>[];
    if (events.any((e) => e.testTask.isWriting)) {
      marker.add(Text('W', style: markerStyle));
    }
    if (events.any((e) => e.testTask.isSpeaking)) {
      marker.add(Text('S', style: markerStyle));
    }
    if (marker.length == 2) {
      marker.insert(1, SizedBox(width: 4));
    }
    if (widget.currentMonthEvents[date]?.isNotEmpty ?? false) {
      return Positioned(bottom: 2, child: Row(children: marker));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Customized header
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Month change buttons
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _canMovePreviousMonth
                  ? () => _onPressedMonthChange(false)
                  : null, // disable
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _canMoveNextMonth
                  ? () => _onPressedMonthChange(true)
                  : null, // disable
            ),

            // Spacer
            const SizedBox(width: 8),

            // Month and year label
            Text(
              DateFormat.yMMMM().format(_focusedDate),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Uses MouseRegion so that a day is deselected when clicking outside calendar.
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (details) {
              // Handles click events on weekday row.
              setState(() {
                _selectedDate = null;
              });
              widget.onDaySelectionCleared.call();
            },
            child:
                // Calendar
                TableCalendar<UserAnswerVM>(
                  key: ValueKey(
                    // Uses the length of the list to rebuild when the list is updated.
                    '${_focusedDate.year}-${_focusedDate.month}-${widget.currentMonthEvents.length}',
                  ),
                  currentDay: null,
                  firstDay: _tappableFirstDay,
                  lastDay: _tappableLastDay,
                  focusedDay: _focusedDate,
                  selectedDayPredicate: (day) {
                    // Marks based on _selectedDate
                    return isSameDay(_selectedDate, day) && _isDayEnabled(day);
                  },
                  enabledDayPredicate: (day) {
                    // Make all days enabled so that they can be clicked,
                    // with the display controlled by defautlBuilder.
                    return true;
                  },
                  // Displays only month format
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  rangeSelectionMode: RangeSelectionMode.disabled,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: true,
                    isTodayHighlighted: false,
                    outsideTextStyle: TextStyle(
                      color: AppColors.disabledTextColor,
                    ),
                  ),
                  headerVisible: false,
                  onDaySelected: _onDaySelected,
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      // Highlights days that have events.
                      final enabled = _isDayEnabled(day);
                      return Center(
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontWeight: enabled
                                ? FontWeight.bold
                                : FontWeight.w400,
                            color: enabled
                                ? AppColors.textColor
                                : AppColors.disabledTextColor,
                          ),
                        ),
                      );
                    },
                    markerBuilder: _markerBuilder,
                    selectedBuilder: (context, date, events) {
                      return Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 6),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ),
                            Text(
                              '${date.day}',
                              style: const TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
