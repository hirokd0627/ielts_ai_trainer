import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ielts_ai_trainer/shared/utils/datetime_utils.dart';

/// Calendar displays marks on days user practiced
class Calendar<T> extends StatefulWidget {
  /// The first selectable year-month
  final DateTime firstEventDay;

  /// The last selectable year-month
  final DateTime lastEventDay;

  /// The initially selected date
  final DateTime initialSelectedDate;

  /// Events in current displayed month
  final Map<DateTime, List<T>> currentMonthEvents;

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
  State<Calendar<T>> createState() => _CalendarState<T>();
}

/// State for Calendar
class _CalendarState<T> extends State<Calendar<T>> {
  /// Current displayed Year and Month
  late DateTime _focusedDate;

  /// Current selected date
  late DateTime? _selectedDate;

  /// The fist day that can be tapped
  late final DateTime _tappableFirstDay;

  /// The last day that can be tapped
  late final DateTime _tappableLastDay;

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
    });

    if (dt != null) {
      widget.onDaySelected.call(selectedDay, focusedDay);
    } else {
      widget.onDaySelectionCleared.call();
    }
  }

  /// Handles the event when the selected month is changed.
  ///
  /// If next is true, moves to the next month. otherwise, moves to the previous month.
  void _onPressedMonthChange(bool next) {
    final (y, m) = next
        ? nextYearMonth(_focusedDate.year, _focusedDate.month)
        : previousYearMonth(_focusedDate.year, _focusedDate.month);

    // Clamp datetime between event date range.
    var nextFocusedDate = DateTime(y, m);
    if (nextFocusedDate.isBefore(widget.firstEventDay)) {
      nextFocusedDate = widget.firstEventDay;
    } else if (nextFocusedDate.isAfter(widget.lastEventDay)) {
      nextFocusedDate = widget.lastEventDay;
    }

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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),

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
                TableCalendar<T>(
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
                            color: enabled ? Colors.black : Colors.grey,
                          ),
                        ),
                      );
                    },
                    markerBuilder: (_, day, _) {
                      // Displays marks in days that have events.
                      final date = DateTime(day.year, day.month, day.day);
                      if (widget.currentMonthEvents[date]?.isNotEmpty ??
                          false) {
                        return Positioned(
                          bottom: 4,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
