import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_client/models/timeslot.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Get the hours from timestamp in the format i.e 3PM
String get12HoursAsString(Timestamp? timestamp, String localCode) {
  if (timestamp == null) return '';

  // Formate the timestamp based on the local code passed
  return DateFormat('j', localCode).format(timestamp.toDate());
}

String getDayString(Timeslot timeslot, String localCode) {
  return DateFormat('EEEE', localCode).format(timeslot.dateFrom.toDate());
}

String getFullDateAsNumbers(Timestamp timestamp) {
  return DateFormat('yMd').format(timestamp.toDate());
}
