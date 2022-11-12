import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_core/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isRatedOrderProvider = StateProvider.family<bool, Order>((ref, order) {
  bool isRated = false;
  order.rating?.forEach((orderRate) {
    if (orderRate.uid == ref.watch(carOwnerStateProvider)?.uid) {
      isRated = true;
    }
  });
  return isRated;
});
