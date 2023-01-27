import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/orders/presentation/controllers/orders_controller.dart';
import 'package:garage_client/features/orders/presentation/widgets/no_orders_widget.dart';
import 'package:garage_client/features/orders/presentation/widgets/order_list_item.dart';
import 'package:garage_client/global_providers/orders_provider.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/enums/order_status.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  late final OrdersViewController _viewController = OrdersViewController(context: context, ref: ref);

  @override
  Widget build(BuildContext context) {
    return Sheet(
      title: "orders.orders_history".translate(),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          child: ref.watch(orderStreamProvider).build((orders) {
            final undeletedPaidOrders =
                orders.where((order) => order.status != OrderStatus.deleted && order.isPaid).toList();
            return undeletedPaidOrders.isNotEmpty
                ? Column(
                    children: [
                      ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => SpacingConst.vSpacing8,
                          shrinkWrap: true,
                          itemCount: undeletedPaidOrders.length,
                          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                          itemBuilder: (context, index) {
                            final order = undeletedPaidOrders[index];
                            return OrderListItem(
                              order: order,
                              onPressed: _viewController.navigateToOrderDetails,
                              getOrderStatusColor: _viewController.getOrderStatusColor,
                            );
                          }),
                    ],
                  )
                : NoOrdersWidget(
                    onButtonPressed: _viewController.navigateToHomeScreen,
                  );
          })),
    );
  }
}
