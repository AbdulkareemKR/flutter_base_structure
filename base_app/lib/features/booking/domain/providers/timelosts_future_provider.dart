import 'dart:developer';

import 'package:garage_client/app.dart';
import 'package:garage_client/features/booking/domain/models/timeslot_group.dart';
import 'package:garage_client/features/booking/domain/providers/timeslots_provider.dart';
import 'package:garage_client/global_services/models/timeslot.dart';
import 'package:garage_client/global_services/models/user_car.dart';
import 'package:garage_client/global_services/services/cars_repo.dart';
import 'package:garage_client/global_services/services/date_time_repo.dart';
import 'package:garage_client/global_services/services/timeslot_repo.dart';
import 'package:garage_client/global_services/services/timeslots_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'timelosts_future_provider.g.dart';

@riverpod
Future<Map<String, List<TimeslotGroup>>> getTimeslots(GetTimeslotsRef ref, String? serviceId, UserCar car) async {
  try {
    final timeslots = await getAvailableTimeslots(serviceId!);

    /// In case the user ordered [OtherServices] then we need
    /// to filter by [ServiceProviders] that offers this service.
    final validServiceProviders = ref.watch(validServiceProvidersProvider);

    final List<Timeslot> validTimeslots;

    if (validServiceProviders.isNotEmpty) {
      validTimeslots = timeslots
          .where(((timeslot) =>
              validServiceProviders.any((serviceProvider) => serviceProvider.uid == timeslot.serviceProviderId)))
          .toList();
    } else {
      /// In case of no filter we simply uses the original timeslots.
      validTimeslots = timeslots;
    }

    final List<Timeslot> applicableTimeslots = [];
    final constCar = await ref.read(carsRepoProvider).getCarFromId(car.carId!);

    /// Excluding timeslots that are not available for the selected car type.
    for (final timeslot in validTimeslots) {
      if (await ref.watch(timeslotsRepoProvider).isTimeslotApplicableForCarType(constCar!.type, timeslot)) {
        applicableTimeslots.add(timeslot);
      }
    }

    final timeslotsByDay = groupTimeslotsByDay(applicableTimeslots, App.localeCode);

    final Map<String, List<TimeslotGroup>> timeslotGroupsMap = {};

    for (final day in timeslotsByDay.keys) {
      final timeslotsList = timeslotsByDay[day]!;
      final Map<String, List<Timeslot>> timeslotGroups = {};
      for (final timeslot in timeslotsList) {
        final durationText = ref.read(dateTimeRepo).getTimeRange(timeslot.dateFrom, timeslot.dateTo);
        if (timeslotGroups.containsKey(durationText)) {
          timeslotGroups[durationText]!.add(timeslot);
        } else {
          timeslotGroups[durationText] = [timeslot];
        }
      }

      for (final uniqeTime in timeslotGroups.keys) {
        final timeslotGroup = TimeslotGroup(
            durationString: uniqeTime,
            timeFrom: timeslotGroups[uniqeTime]!.first.dateFrom,
            timeTo: timeslotGroups[uniqeTime]!.first.dateTo,
            timeslots: timeslotGroups[uniqeTime]!);

        if (timeslotGroupsMap.containsKey(day)) {
          timeslotGroupsMap[day]!.add(timeslotGroup);
        } else {
          timeslotGroupsMap[day] = [timeslotGroup];
        }
      }
    }

    return timeslotGroupsMap;
  } catch (e) {
    log('$e');
    ;

    // In case the serviceId is null
    //
    throw Exception("Invalid service id provided $serviceId");
  }
}
