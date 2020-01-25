import 'package:intl/intl.dart';

class DateUtils {
  static DateTime getFirstDayOfWeek(DateTime date) {
    return date.subtract(new Duration(days: date.weekday));
  }

  static DateTime getLastDayOfWeek(DateTime date) {
    return date.add(new Duration(days: date.weekday));
  }

  static DateTime getStartOfDay(DateTime date) {
    return date.subtract(new Duration(hours: date.hour));
  }

  static DateTime addDayToDate(DateTime date, int days)  {
    return date.add(new Duration(days: days));
  }

  static DateTime addHourToDate(DateTime date, int hour) {
    return date.add(new Duration(hours: hour));
  }

  static String getWeekDayName(DateTime date) {
    String formattedDate = DateFormat('EEE').format(date);
    return formattedDate;
  }
}