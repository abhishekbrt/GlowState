import 'package:intl/intl.dart';

abstract final class AppDateUtils {
  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');
  static final DateFormat _timeFormat = DateFormat('h:mm a');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayFormat = DateFormat('EEE');

  static String formatDate(DateTime date) => _dateFormat.format(date);

  static String formatTime(DateTime time) => _timeFormat.format(time);

  static String formatMonthYear(DateTime date) => _monthYearFormat.format(date);

  static String formatDay(DateTime date) => _dayFormat.format(date);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool isToday(DateTime date) => isSameDay(date, DateTime.now());

  static bool isMorning(DateTime time) {
    final hour = time.hour;
    return hour >= 5 && hour < 12;
  }

  static bool isNight(DateTime time) {
    final hour = time.hour;
    return hour >= 18 || hour < 5;
  }

  static int daysBetween(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime endOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 23, 59, 59);

  static DateTime startOfMonth(DateTime date) =>
      DateTime(date.year, date.month);

  static int daysInMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0).day;
}
