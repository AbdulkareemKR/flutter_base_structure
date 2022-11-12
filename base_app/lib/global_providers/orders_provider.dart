import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/order_repo.dart';
import 'package:garage_client/global_services/services/service_providers_repo.dart';
import 'package:garage_client/global_services/models/serivce_provider.dart';

final activeOrderStream = StreamProvider<Order?>(
  (ref) {
    return (ref.watch(orderRepoProvider).getActiveOrderStream(ref.watch(carOwnerStateProvider)?.uid ?? ""));
  },
);

final activeOrderProvider = StateProvider<Order?>(
  (ref) {
    return ref
        .watch(activeOrderStream)
        .when(data: (order) => order, error: (error, stack) => null, loading: () => null);
  },
);

final orderServiceProvider = FutureProvider.family<ServiceProvider?, Order?>((ref, order) {
  return ref.read(serviceProviderRepoProvider).getServiceProviderFromUid(order?.serviceProviderId ?? "");
});

final isVisibleOrderProvider = StateProvider<bool>((ref) {
  return ref.watch(activeOrderStream).when(
      data: (order) {
        if (order == null) {
          return false;
        } else if (order.isVisible == null) {
          return true;
        } else {
          return order.isVisible!;
        }
      },
      error: (error, stack) => false,
      loading: () => false);
});

final orderStreamProvider = StreamProvider<List<Order>>(((ref) => ref.watch(orderRepoProvider).getOrdersStream(
      ref.watch(carOwnerStateProvider)?.uid ?? "",
    )));
