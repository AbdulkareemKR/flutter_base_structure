import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/models/timeslot.dart';

part 'nearest_timeslot_body.freezed.dart';

@freezed
class NearestTimeslotBody with _$NearestTimeslotBody {
  factory NearestTimeslotBody({
    required Service service,
    required List<Timeslot> timeslots,
  }) = _NearestTimeslotBody;
}
