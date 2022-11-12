import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_core/models/service.dart';
import 'package:garage_core/services/services_services.dart';

final subServicesProvider = FutureProvider.family<List<Service>, String>((ref, serviceId) async {
  final carOwner = ref.watch(carOwnerProvider).asData?.value;

  return getServicesFromParent(serviceId, carOwner?.defaultCar?.carId ?? '');
});
