import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:garage_client/features/tracking_order/domain/providers/order_rating_notifier.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/order_accepted.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/order_being_handled.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/order_completed.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/order_in_the_way.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/order_requested.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_providers/orders_provider.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/global_services/services/order_repo.dart';

class TrackingOrderController {
  final BuildContext context;
  final WidgetRef ref;

  TrackingOrderController({required this.ref, required this.context});

  /// This method will display the TrackingOrderView based on [OrderStatus] enum value
  Widget orderStatusView(OrderStatus orderStatus, Order order) {
    switch (orderStatus) {
      case OrderStatus.underProcessing:
        return const OrderRequested();
      case OrderStatus.accepted:
        return const OrderAccepted();
      case OrderStatus.inTheWay:
        return const OrderInTheWay();
      case OrderStatus.beingHandled:
        return const OrderBeingHandled();
      case OrderStatus.completed:
        return OrderCompleted(order: order);
      default:
        return const OrderRequested();
    }
  }

  void ratingSubmitHandler() {
    final ratingInfo = ref.read(orderRatingProvider);
    OrderRate orderRate = OrderRate(
      uid: ref.read(carOwnerStateProvider)?.uid ?? "",
      rate: ratingInfo!.rating!,
      comment: ratingInfo.comment ?? "",
      userType: UserType.carOwner,
    );

    ref.read(orderRepoProvider).postOrderRating(orderId: ratingInfo.orderId ?? "", orderRate: orderRate);
    ref.read(isVisibleOrderProvider.state).state = false;
    ref.read(orderRepoProvider).hideOrder(ratingInfo.orderId ?? "");
    EasyNavigator.popPage(context);
  }

  void onChangeRating(int pressedStarIndex) {
    ref.read(orderRatingProvider.notifier).updateOrderRate(pressedStarIndex);
  }

  void onRatingCommentChange(String comment) {
    ref.read(orderRatingProvider.notifier).updateOrderNote(comment);
  }

  void onHelpSupportClick() {
    // TODO: handling help button click
  }
}
