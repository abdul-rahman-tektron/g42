import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin CommonUtils {
  static TimeOfDay? parseTimeStringToTimeOfDay(String timeStr) {
    try {
      final parsedTime = DateFormat.jm().parse(timeStr);
      return TimeOfDay.fromDateTime(parsedTime);
    } catch (e) {
      print("Failed to parse time: $e");
      return null;
    }
  }

  static TimeOfDay? parseFullDateStringToTimeOfDay(String fullDateStr) {
    try {
      final parsedDateTime = DateFormat("dd/MM/yyyy, hh:mm a").parse(fullDateStr);
      return TimeOfDay.fromDateTime(parsedDateTime);
    } catch (e) {
      print("Failed to parse time: $e");
      return null;
    }
  }

  static bool isBeforeTimeOfDay(TimeOfDay a, TimeOfDay b) {
    return a.hour < b.hour || (a.hour == b.hour && a.minute < b.minute);
  }

  static bool isAfterTimeOfDay(TimeOfDay a, TimeOfDay b) {
    return a.hour > b.hour || (a.hour == b.hour && a.minute > b.minute);
  }

  static String formatIsoToReadable(String isoDateStr) {
    try {
      final dateTime = DateTime.parse(isoDateStr);
      final formatter = DateFormat("MMM d, y 'at' h:mm a");
      return formatter.format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return isoDateStr; // fallback to original
    }
  }
}