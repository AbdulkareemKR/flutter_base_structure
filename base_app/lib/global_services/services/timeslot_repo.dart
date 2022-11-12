import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/models/serivce_provider.dart';
import 'package:garage_core/models/service.dart';
import 'package:garage_core/models/timeslot.dart';
import 'package:garage_core/models/user_car.dart';
import 'package:garage_core/services/cars_repo.dart';
import 'package:garage_core/services/firestore_repo.dart';
import 'package:garage_core/services/service_providers_repo.dart';
import 'package:garage_core/services/timeslots_services.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';
import 'package:intl/intl.dart';

final timeslotsRepoProvider = Provider<TimeslotsRepo>((ref) {
  return TimeslotsRepo(
      firestoreRepo: ref.watch(firestoreRepoProvider),
      serviceProvidersRepo: ref.watch(serviceProviderRepoProvider),
      ref: ref);
});

class TimeslotsRepo {
  final ServiceProvidersRepo serviceProvidersRepo;
  final FirestoreRepo firestoreRepo;
  final Ref ref;
  TimeslotsRepo({required this.serviceProvidersRepo, required this.firestoreRepo, required this.ref});

  /// This method will be used on each timelsot to check that the service provider
  ///
  /// that offers this timelsot dose support the car type of the user's car
  ///
  /// if so it will return true, false otherwise.
  Future<bool> isTimeslotApplicableForCarType(CarType carType, Timeslot timeslot) async {
    try {
      /// Get the service Provider for that timeslot
      final serviceProvider = await serviceProvidersRepo.getServiceProviderFromUid(timeslot.serviceProviderId);
      if (serviceProvider is ServiceProvider) {
        /// Check that the service provider is not null and had services
        if (serviceProvider.availableServices != null && serviceProvider.availableServices!.isNotEmpty) {
          ///Search for a service contain [carType] and has the same [serviceId]
          final isServiceApplicable = serviceProvider.availableServices!.any((availableService) =>
              availableService.carTypes!.contains(carType) && availableService.id == timeslot.serviceId);

          /// Return whether the service is found or not.
          return isServiceApplicable;
        } else {
          /// In any other case return false
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      /// If any exception occurred
      e.logException();
      return false;
    }
  }

  Future<Map<String, dynamic>> getNearestTimeslot(List<Service> services, UserCar userCar) async {
    final constCar = await ref.read(carsRepoProvider).getCarFromId(userCar.carId!);
    for (final service in services) {
      final timeslots = await getAvailableTimeslots(service.id);
      final List<Timeslot> applicableTimeslots = [];
      for (final timeslot in timeslots) {
        if (await isTimeslotApplicableForCarType(constCar!.type, timeslot)) {
          log('true for' + timeslot.toString());
          applicableTimeslots.add(timeslot);
        }
      }
      if (applicableTimeslots.isNotEmpty) {
        return {'service': service, 'timeslot': timeslots};
      }
    }
    return throw Exception("Couldn't find any nearest timeslot for $services");
  }
}
