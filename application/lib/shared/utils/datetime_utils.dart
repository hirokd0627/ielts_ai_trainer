/// Returns the next year and month for the given year and month.
(int year, int month) nextYearMonth(int year, int month) {
  year = (month == 12) ? year + 1 : year;
  month = (month == 12) ? 1 : month + 1;
  return (year, month);
}

/// Returns the previous year and month for the given year and month.
(int year, int month) previousYearMonth(int year, int month) {
  year = (month == 1) ? year - 1 : year;
  month = (month == 1) ? 12 : month - 1;
  return (year, month);
}

/// Returns the last day of the month for the given year and month.
int lastDayOfMonth(int year, int month) {
  final (nextYear, nextMonth) = nextYearMonth(year, month);
  final dt = DateTime(nextYear, nextMonth).subtract(const Duration(days: 1));
  return dt.day;
}
