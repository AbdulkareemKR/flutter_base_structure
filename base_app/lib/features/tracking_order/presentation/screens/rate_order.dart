import 'package:flutter/material.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/order_completed.dart';
import 'package:garage_core/models/order.dart';

class RateOrder extends StatelessWidget {
  final Order order;
  const RateOrder({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Remve this class, it's totally useless!
    return OrderCompleted(order: order);
  }
}
