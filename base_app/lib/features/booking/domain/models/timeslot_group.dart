import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/global_services/models/timeslot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'timeslot_group.freezed.dart';

@freezed
class TimeslotGroup with _$TimeslotGroup {
  factory TimeslotGroup({
    required String durationString,
    required Timestamp timeFrom,
    required Timestamp timeTo,
    required List<Timeslot> timeslots,
  }) = _TimeslotGroup;
}
