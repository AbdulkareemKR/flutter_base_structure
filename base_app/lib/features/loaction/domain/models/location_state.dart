import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/features/loaction/domain/enums/location_view_mode.dart';
import 'package:garage_core/models/order.dart';

part 'location_state.freezed.dart';
part 'location_state.g.dart';

@freezed
class LocationState with _$LocationState {
  factory LocationState({bool? isBeingEditedLocation, String? editedLocationId, required LocationViewMode viewMode}) = _LocationState;

  factory LocationState.fromJson(Map<String, dynamic> json) => _$LocationStateFromJson(json);
}
