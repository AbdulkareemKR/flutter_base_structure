import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_client/models/order.dart';
import 'package:garage_client/models/timeslot.dart';
import 'package:intl/intl.dart';

Map<String, String> localMap = {"ar": "ar_sa", "en": "en_us"};

/// Get the hours from timestamp in the format i.e 3PM
String get12HoursAsString(Timestamp? timestamp, String localCode) {
  if (timestamp == null) return '';

  // Formate the timestamp based on the local code passed
  return DateFormat('j', localMap[localCode]).format(timestamp.toDate());
}

String getDayString(Timeslot timeslot, String localCode) {
  return DateFormat('EEEE', localMap[localCode]).format(timeslot.dateFrom.toDate());
}

String getFullDate(Timestamp? timestamp, String localCode) {
  if (timestamp == null) return '';
  return DateFormat('yMd', localMap[localCode]).format(timestamp.toDate());
}

String getMonthAndDayString(DateTime dateTime, String localCode) {
  return DateFormat('MMMMd', localMap[localCode]).format(dateTime);
}

String getMonthAndDayAndYearString(DateTime dateTime, String localCode) {
  return DateFormat('yMMMMd', localMap[localCode]).format(dateTime);
}

String getAbbrMonthAndDayAndYearString(DateTime dateTime, String localCode) {
  return DateFormat('yMMMd', localMap[localCode]).format(dateTime);
}

String getDurationToFinishService(Order order) {
  final dateTo = order.timeslot.dateTo.toDate();
  final durationLeft = dateTo.difference(DateTime.now()).toString();
  // Since the string is too long we will cut it
  final formattedString = durationLeft.substring(0, durationLeft.indexOf('.'));
  return formattedString;
}
