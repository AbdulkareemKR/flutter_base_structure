import 'package:flutter/material.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/global_services/services/date_time_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/services/services_repo.dart';

class OrderListItem extends ConsumerStatefulWidget {
  final void Function(Order) onPressed;
  final Order order;
  final Color Function(OrderStatus) getOrderStatusColor;

  const OrderListItem({
    Key? key,
    required this.onPressed,
    required this.order,
    required this.getOrderStatusColor,
  }) : super(key: key);

  @override
  ConsumerState<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends ConsumerState<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(widget.order),
      child: Container(
        height: 63.h,
        width: 310.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusConst.smallBorderRadius,
          color: ColorsConst.white,
          boxShadow: [ShadowConst.blackShadow],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusConst.smallBorderRadius,
                  color: ColorsConst.cultured,
                ),
                child: Icon(
                  GarageIcons.Car,
                  color: ColorsConst.cosmicCobalt,
                  size: 20.w,
                ),
              ),
              SpacingConst.hSpacing6,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ref.watch(serviceRootParentProvider(widget.order.selectedServices.first.id)).maybeWhen(
                      data: (rootService) => Text(
                            rootService?.name.translated ?? "",
                            style: context.textThemes.bodyMedium,
                          ),
                      orElse: () => const Text("")),
                  widget.order.orderDates?.orderDate != null
                      ? Text(
                          getMonthAndDayAndYearString(widget.order.orderDates!.orderDate, App.lang),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SpacingConst.spacing6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing6.w),
                      decoration: BoxDecoration(
                        color: ColorsConst.cultured,
                        borderRadius: BorderRadiusConst.smallBorderRadius,
                      ),
                      child: Text(
                        "order_status.${widget.order.status.name}".translate(),
                        style: context.textThemes.caption?.regular
                            .copyWith(color: widget.getOrderStatusColor(widget.order.status)),
                      ),
                    ),
                    widget.order.transaction?.finalAmount != null
                        ? Row(
                            children: [
                              Text(
                                "${widget.order.transaction!.finalAmount}",
                                style: context.textThemes.caption?.copyWith(color: ColorsConst.dartGrey),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                "currency.${widget.order.transaction!.currency.name}".translate(),
                                style: context.textThemes.caption?.copyWith(color: ColorsConst.dartGrey),
                              ),
                            ],
                          )
                        : Text(
                            "orders.price_not_specified".translate(),
                            style: context.textThemes.caption?.copyWith(color: ColorsConst.dartGrey),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
