import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// Calendar displays marks on days user practiced
class Calendar<T> extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar<T>> createState() => _CalendarState<T>();
}

/// State for Calenar
class _CalendarState<T> extends State<Calendar<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Customized header
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),

            IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),

            // Spacer
            const SizedBox(width: 8),

            Text(
              DateFormat.yMMMM().format(DateTime.now()),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // Calendar
        TableCalendar<T>(
          currentDay: null,
          firstDay: DateTime.now(),
          lastDay: DateTime.now(),
          focusedDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          rangeSelectionMode: RangeSelectionMode.disabled,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: true,
            isTodayHighlighted: false,
          ),
          headerVisible: false, // use customized header
        ),
      ],
    );
  }
}
