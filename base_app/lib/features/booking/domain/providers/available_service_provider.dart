import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/booking/domain/models/available_service_data.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_core/models/available_service.dart';
import 'package:garage_core/services/services_repo.dart';
import 'package:garage_core/services/services_services.dart';

final availableServiceProvider =
    FutureProvider.family.autoDispose<AvailableService, AvailableServiceData>((ref, availableServiceData) async {
  return ref
      .read(servicesRepoProvider)
      .getAvailableServiceForServiceProvider(availableServiceData.serviceId, availableServiceData.serviceProviderId);
});

final servicePriceProvider =
    FutureProvider.family.autoDispose<num, AvailableServiceData>((ref, availableServiceData) async {
  return getServicePriceForServiceProvider(availableServiceData.serviceId, availableServiceData.serviceProviderId, ref.watch(carOwnerProvider).value?.defaultCar?.carId);
});
