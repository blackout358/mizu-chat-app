import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampFormater {
  static String formatTimestamp(Timestamp time) {
    // Convert Timestamp to DateTime
    DateTime dateTime = time.toDate();

    // Extract hour and minute
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    // Format hour and minute as HH:mm
    String hourMinute = "$hour:${minute.toString().padLeft(2, '0')}";

    return hourMinute; // Return the formatted time
  }
}
