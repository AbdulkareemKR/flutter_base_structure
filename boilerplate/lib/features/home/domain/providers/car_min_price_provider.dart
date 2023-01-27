import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/home/domain/providers/active_car_index_provider.dart';
import 'package:garage_client/global_providers/user_cars_provider.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/services/car_services.dart';

final carMinPriceProvider = FutureProvider.family.autoDispose<double, Service>((ref, service) async {
  return ref.watch(userCarsProvider).maybeWhen(
        data: (cars) async {
          if (cars.isNotEmpty) {
            final currentIndex = ref.watch(activeCarIndexProvider);
            return getMinPriceForService(cars[currentIndex], service);
          } else {
            return service.priceRange.min;
          }
        },
        orElse: () => 0.0,
      );
});
