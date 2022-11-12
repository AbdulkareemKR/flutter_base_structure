import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_core/models/timeslot.dart';

part 'available_service_data.freezed.dart';

@freezed
class AvailableServiceData with _$AvailableServiceData {
  factory AvailableServiceData({required String serviceId, required String serviceProviderId}) = _ServicePriceData;

  factory AvailableServiceData.fromTimeslot({required Timeslot timeslot}) =>
      AvailableServiceData(serviceId: timeslot.serviceId, serviceProviderId: timeslot.serviceProviderId);
}
