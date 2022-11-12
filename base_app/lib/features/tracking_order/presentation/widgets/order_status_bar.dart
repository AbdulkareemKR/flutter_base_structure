import 'package:flutter/material.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:garage_client/global_services/enums/order_status.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusBar extends StatelessWidget {
  final OrderStatus orderStatus;
  const OrderStatusBar({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        // we have 5 [orderStatus] for active orders cycle
        5,
        (index) => Row(
          children: [
            Container(
              height: 7.h,
              width: OrderStatus.values.indexOf(orderStatus) >= index ? 33.w : 19.w,
              decoration: BoxDecoration(
                color: getOrderStatusBarColor(index),
                borderRadius: smallBorderRadius,
              ),
            ),
            SpacingConst.hSpacing6,
          ],
        ),
      ),
    );
  }

  Color getOrderStatusBarColor(int index) {
    if (OrderStatus.values.indexOf(orderStatus) == index) {
      return ColorsConst.cosmicCobalt;
    } else if (OrderStatus.values.indexOf(orderStatus) > index) {
      return ColorsConst.cosmicCobalt.shade300;
    } else {
      return ColorsConst.disableGrey;
    }
  }
}
