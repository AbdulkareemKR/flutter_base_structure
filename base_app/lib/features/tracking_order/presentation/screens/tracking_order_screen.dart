import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/tracking_order/presentation/controllers/tracking_order_controller.dart';
import 'package:garage_client/features/tracking_order/presentation/widgets/order_status_bar.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_core/models/order.dart';
import 'package:garage_core/services/order_repo.dart';
import 'package:garage_core/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_client/utils/general_extensions.dart';

class TrackingOrderScreen extends ConsumerStatefulWidget {
  final String orderId;
  const TrackingOrderScreen({required this.orderId, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends ConsumerState<TrackingOrderScreen> {
  late final TrackingOrderController _viewController = TrackingOrderController(context: context, ref: ref);

  @override
  Widget build(BuildContext context) {
    return ref.watch(streamedOrderProvider(widget.orderId)).build(
          (order) => ConditionaryWidget(
            condition: order != null,
            trueWidget: AnimatedContainer(
              height: 700.h,
              duration: const Duration(milliseconds: 400),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SpacingConst.vSpacing20,
                  OrderStatusBar(orderStatus: order!.status),
                  SingleChildScrollView(child: _viewController.orderStatusView(order.status, order)),
                  const Spacer(),
                  Padding(
                      padding: EdgeInsets.only(bottom: SpacingConst.spacing60.h),
                      child: ConditionaryWidget(
                        condition: order.status != OrderStatus.completed,
                        trueWidget: CustomButton(
                          label: "orders.help_support".translate(),
                          icon: null,
                          onPressed: _viewController.onHelpSupportClick,
                          style: CustomButtonStyle.secondary,
                          width: 200.w,
                          height: 50.h,
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
  }
}
