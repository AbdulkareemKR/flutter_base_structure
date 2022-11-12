import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/tracking_order/domain/models/order_rating.dart';

class LoginInfoNotifier extends StateNotifier<OrderRatingInfo?> {
  final Ref ref;
  LoginInfoNotifier(
    OrderRatingInfo? state,
    this.ref,
  ) : super(state);

  void updateOrderNote(String orderComment) {
    state = state?.copyWith(comment: orderComment);
  }

  void updateOrderRate(int rating) {
    state = state?.copyWith(rating: rating);
  }

  void updateOrderId(String orderId) {
    state = state?.copyWith(orderId: orderId);
  }
}

final orderRatingProvider = StateNotifierProvider.autoDispose<LoginInfoNotifier, OrderRatingInfo?>((ref) {
  return LoginInfoNotifier(const OrderRatingInfo(rating: 0), ref);
});
