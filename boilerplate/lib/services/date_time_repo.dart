import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateTimeRepo = Provider<DateTimeRepo>(
  (ref) => DateTimeRepo(),
);

class DateTimeRepo {
  String getTimestampFormatted(Timestamp date) {
    return getDateFormatted(date.toDate());
  }

  String getTimeRange(Timestamp from, Timestamp to, {String? localeCode}) {
    final fromString = DateFormat(DateFormat.HOUR_MINUTE, localeCode).format(from.toDate());
    final toString = DateFormat(DateFormat.HOUR_MINUTE, localeCode).format(to.toDate());

    return fromString + ' - ' + toString;
  }

  String getHourTimeRange(Timestamp from, Timestamp to, {String? localeCode}) {
    final fromString = DateFormat(DateFormat.HOUR_MINUTE, localeCode).format(from.toDate());
    final toString = DateFormat(DateFormat.HOUR_MINUTE, localeCode).format(to.toDate());

    return fromString + '-' + toString;
  }

  String getTodayDateFormatted() {
    return getDateFormatted(DateTime.now());
  }

  String getDateFormatted(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  String getDayNameAndNumber(DateTime date, String localeCode) {
    return DateFormat('EEEE', localeCode).format(date) + " " + DateFormat('Md', localeCode).format(date);
  }

  String getDate12HFormatted(DateTime date) {
    return DateFormat(DateFormat.HOUR_MINUTE).format(date);
  }

  String getClassicDateFormat(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
