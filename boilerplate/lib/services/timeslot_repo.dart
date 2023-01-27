import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/models/car_owner.dart';
import 'package:garage_client/models/nearest_timeslot_body.dart';
import 'package:garage_client/models/serivce_provider.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/models/timeslot.dart';
import 'package:garage_client/models/user_car.dart';
import 'package:garage_client/services/cars_repo.dart';
import 'package:garage_client/services/firestore_repo.dart';
import 'package:garage_client/services/service_providers_repo.dart';
import 'package:garage_client/services/timeslots_services.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

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
  Future<bool> isTimeslotApplicableForCarTypeAndUserLocation(
      {required CarOwner? carOwner, required Timeslot timeslot, required CarType carType}) async {
    try {
      /// Get the service Provider for that timeslot
      final serviceProvider = await serviceProvidersRepo.getServiceProviderFromUid(timeslot.serviceProviderId);
      if (serviceProvider is ServiceProvider) {
        /// Check that the service provider covers the neighborhood of the use and his services are not null and not empty
        if ((serviceProvider.coveredNeighborhoods?.contains(carOwner?.defaultLocation?.neighborhood?.id) ?? false) &&
            serviceProvider.availableServices != null &&
            serviceProvider.availableServices!.isNotEmpty) {
          ///Search for a service contain [carType] and has the same [serviceId]
          final isServiceApplicable = serviceProvider.availableServices!.any((availableService) =>
              availableService.carTypes!.contains(carType) && timeslot.serviceId.contains(availableService.id));

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

  Future<NearestTimeslotBody> getNearestTimeslot({required List<Service> services, required CarOwner? carOwner}) async {
    final constCar = await ref.read(carsRepoProvider).getCarFromId(carOwner!.defaultCar!.carId!);
    for (final service in services) {
      final timeslots = await getAvailableTimeslots(service.id);
      final List<Timeslot> applicableTimeslots = [];
      for (final timeslot in timeslots) {
        if (await isTimeslotApplicableForCarTypeAndUserLocation(
            carOwner: carOwner, carType: constCar!.type, timeslot: timeslot)) {
          log('true for$timeslot');
          applicableTimeslots.add(timeslot);
        }
      }
      if (applicableTimeslots.isNotEmpty) {
        return NearestTimeslotBody(timeslots: timeslots, service: service);
      }
    }
    return throw Exception("Couldn't find any nearest timeslot for $services");
  }
}
