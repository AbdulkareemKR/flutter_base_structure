import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/features/orders/presentation/screens/order_details_screen.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/rate_order.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/tracking_order_screen.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/bottom_sheet_navigator.dart';

class OrdersViewController {
  final BuildContext context;
  final WidgetRef ref;

  OrdersViewController({required this.context, required this.ref});

  void navigateToOrderDetails(Order order) {
    EasyNavigator.openPage(page: OrderDetailsScreen(orderId: order.id ?? ""), context: context);
  }

  void navigateToHomeScreen() {
    EasyNavigator.popToFirstView(context);
  }

  Color getOrderStatusColor(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.completed:
        return ColorsConst.positiveGreen;

      case OrderStatus.cancelled:
      case OrderStatus.rejected:
      case OrderStatus.deleted:
        return ColorsConst.negativeRed;

      default:
        return ColorsConst.warningYellow;
    }
  }

  void onLostItemsPressed() {
    // TODO: hadling users' lost items
  }

  void onCarProblemsPressed() {
    // TODO: hadling users' cars problems
  }

  void onServiceRatingPressed(Order order) {
    EasyNavigator.openPage(context: context, page: RateOrder(order: order));
  }

  void onTrackOrderPressed(String orderId) {
    EasyNavigator.openPage(context: context, page: TrackingOrderScreen(orderId: orderId));
  }
}
