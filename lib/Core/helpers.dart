import 'package:intl/intl.dart';

class TemperatureHelper {
  static String getTemperature(int value) {
    if (value <= 0) {
      return "$value\u00B0C";
    }
    return "+$value\u00B0C";
  }
}

class DateHelper {
  static String getDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  static String getTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  static const weekday = [
    "",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
}
