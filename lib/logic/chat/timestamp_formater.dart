import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampFormater {
  static String getHourMinute(Timestamp time) {
    DateTime dateTime = time.toDate();

    int hour = dateTime.hour;
    int minute = dateTime.minute;

    String hourMinute = "$hour:${minute.toString().padLeft(2, '0')}";

    return hourMinute;
  }

  static String getDate(Timestamp time) {
    DateTime dateTime = time.toDate();

    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString().padLeft(2, '0');

    return "$day/$month/$year";
  }

  static String getDayOfWeek(int day) {
    List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return daysOfWeek[day - 1];
  }

  static String formatTime(Timestamp time) {
    DateTime dateTime = time.toDate();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final weekAgo = DateTime(now.year, now.month, now.day - 7);
    var date = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
    if (today == date) {
      return getHourMinute(time);
    } else if (date == yesterday) {
      return 'Yesterday';
    } else if ((date.isAfter(weekAgo))) {
      return getDayOfWeek(date.weekday);
    } else {
      return getDate(time);
    }
  }
}
