import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterTimestamp extends Timestamp {
  FlutterTimestamp(int seconds, int nanoseconds) : super(seconds, nanoseconds);

  static Timestamp parse(dynamic source) {
    if (source is Timestamp) {
      return source;
    } else if (source is Map) {
      if (source['_seconds'] != null && source['_nanoseconds'] != null) {
        return Timestamp(source['_seconds'], source['_nanoseconds']);
      } else if (source['seconds'] != null && source['nanoseconds'] != null) {
        return Timestamp(source['seconds'], source['nanoseconds']);
      } else {
        throw Exception("Couldn't parse timestamp from [Map] because of invalid Timestamp format.");
      }
    } else if (source is DateTime) {
      return Timestamp.fromDate(source);
    } else {
      throw Exception("Couldn't parse timestamp of type ${source.runtimeType}");
    }
  }

  static Map<String, dynamic> toMap(Timestamp timestamp) {
    return {
      '_seconds': timestamp.seconds,
      '_nanoseconds': timestamp.nanoseconds,
    };
  }
}
