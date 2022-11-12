import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/home/presentation/controllers/home_screen_controller.dart';
import 'package:garage_client/global_providers/orders_provider.dart';
import 'package:garage_client/widgets/locale_positioned.dart';
import 'package:garage_core/constants/constants.dart';
import 'package:garage_core/models/order.dart';
import 'package:garage_core/services/date_time_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_core/services/order_repo.dart';
import 'package:garage_core/widgets/conditionary_widget/conditionary_widget.dart';

class ActiveOrderWidget extends ConsumerStatefulWidget {
  final Order order;

  const ActiveOrderWidget({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ActiveOrderWidget> createState() => _ActiveOrderWidgetState();
}

class _ActiveOrderWidgetState extends ConsumerState<ActiveOrderWidget> {
  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(homeScreenControllerProvider);

    return ConditionaryWidget(
      condition: ref.watch(isVisibleOrderProvider),
      trueWidget: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: GestureDetector(
            onTap: () => _controller.onActiveOrderClick(context, widget.order.id ?? ""),
            child: Container(
                height: 146.h,
                width: 375.w,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorsConst.white,
                      // TODO: add the color to Colors const
                      Color(0xffC4BDFF),
                    ],
                  ),
                  borderRadius: smallBorderRadius,
                ),
                child: Stack(
                  children: [
                    LocalePositioned(
                      top: 8.h,
                      localeSide: 340.w,
                      child: GestureDetector(
                        child: Icon(
                          GarageIcons.Quit,
                          size: 23.w,
                        ),
                        onTap: () => ref.read(orderRepoProvider).hideOrder(widget.order.id ?? ""),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "orders.scheduled_service".translate(),
                            style: context.textThemes.bodyLarge?.copyWith(color: ColorsConst.cosmicCobalt),
                          ),
                          Text(
                            widget.order.selectedServices.first.name.translated,
                            style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.dartGrey),
                          ),
                          widget.order.orderDates?.orderDate != null
                              ? Text(
                                  getMonthAndDayString(widget.order.orderDates!.orderDate, App.lang),
                                  style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.dartGrey),
                                )
                              : const SizedBox.shrink(),
                          SpacingConst.vSpacing6,
                          widget.order.transaction?.paymentMethod != null
                              ? Text(
                                  "orders.paidBy".translate(arguments: [
                                    "paymentMethod.${widget.order.transaction!.paymentMethod.name}".translate()
                                  ]),
                                  style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.dartGrey),
                                )
                              : Text(
                                  "paymentMethod.notPaid".translate(),
                                  style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.dartGrey),
                                ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
