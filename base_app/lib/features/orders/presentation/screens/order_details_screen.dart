import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/orders/presentation/controllers/orders_controller.dart';
import 'package:garage_client/features/orders/domain/providers/orders_providers.dart';
import 'package:garage_client/features/orders/presentation/widgets/expandable_container.dart';
import 'package:garage_client/features/orders/presentation/widgets/help_list_item.dart';
import 'package:garage_client/widgets/order_container.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/global_services/services/order_repo.dart';
import 'package:garage_client/global_services/services/services_repo.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/global_services/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_client/utils/general_extensions.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;
  const OrderDetailsScreen({required this.orderId, Key? key}) : super(key: key);

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends ConsumerState<OrderDetailsScreen> {
  late final OrdersViewController _viewController = OrdersViewController(context: context, ref: ref);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      child: ref.watch(streamedOrderProvider(widget.orderId)).build(
            (order) => ConditionaryWidget(
              condition: order != null,
              trueWidget: Sheet(
                title: "orders.order_details_title".translate(),
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 120.h,
                      child: SvgPicture.asset(
                          order!.status == OrderStatus.completed ? AssetsConst.yellowMapSvg : AssetsConst.timeSvg)),
                  Text(
                    "order_status.${order.status.name}".translate(),
                    style: context.textThemes.bodySmall
                        ?.copyWith(color: _viewController.getOrderStatusColor(order.status)),
                  ),
                  SpacingConst.vSpacing16,
                  ExpandableContainer(
                    initialHeight: 55.h,
                    expandedHeight: 110.h,
                    width: 332.w,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "orders.serviceName".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        ),
                        ref.watch(serviceRootParentProvider(order.selectedServices.first.id)).maybeWhen(
                            data: (rootService) => Text(
                                  rootService?.name.translated ?? "",
                                  style: context.textThemes.bodyMedium,
                                ),
                            orElse: () => const Text("")),
                      ],
                    ),
                    details: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "orders.service_type".translate(),
                                style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                              ),
                              Text(
                                order.selectedServices.first.name.translated,
                                style: context.textThemes.bodyMedium,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 140.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "orders.otherServices".translate(),
                                style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                              ),
                              Text(
                                order.otherServices != null && order.otherServices!.isNotEmpty
                                    ? order.otherServices?.first?.name.translated ?? ""
                                    : "doesNotExist".translate(),
                                style: context.textThemes.bodyMedium,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpacingConst.vSpacing8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OrderContainer(
                        width: 165.w,
                        height: 55.h,
                        titleWidget: Text(
                          "orders.location".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        ),
                        contentWidget: Text(
                          order.location.title,
                          style: context.textThemes.bodySmall,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      OrderContainer(
                        width: 165.w,
                        height: 55.h,
                        titleWidget: Text(
                          "orders.payment_method_title".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        ),
                        contentWidget: Text(
                          "paymentMethod.${order.transaction?.paymentMethod.name ?? "notPaid"}".translate(),
                          style: context.textThemes.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  SpacingConst.vSpacing20,
                  Center(
                    child: Text(
                      "orders.help".translate(),
                      style: context.textThemes.bodyLarge,
                    ),
                  ),
                  SpacingConst.vSpacing16,
                  HelpListItem(
                    title: "orders.report_car_safety".translate(),
                    description: "orders.keep_us_informed".translate(),
                    svgString: AssetsConst.infoSquareSvg,
                    onHelpItemPressed: _viewController.onCarProblemsPressed,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                  ),
                  SpacingConst.vSpacing16,
                  HelpListItem(
                    title: "orders.lost_items".translate(),
                    description: "orders.contact_service_provider".translate(),
                    svgString: AssetsConst.bagSvg,
                    onHelpItemPressed: _viewController.onLostItemsPressed,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                  ),
                  SpacingConst.vSpacing16,
                  ConditionaryWidget(
                    condition: order.isActiveOrder,
                    trueWidget: HelpListItem(
                      title: "orders.trackOrder".translate(),
                      description: "orders.trackOrderDescription".translate(),
                      svgString: AssetsConst.starSvg,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      onHelpItemPressed: () => _viewController.onTrackOrderPressed(order.id ?? ""),
                    ),
                    falseWidget: Consumer(builder: (context, ref, child) {
                      final isRatedOrder = ref.watch(isRatedOrderProvider(order));
                      return ConditionaryWidget(
                          // If the order is completed and not rated yet, show "rate us widget"
                          condition: order.status == OrderStatus.completed && !isRatedOrder,
                          trueWidget: HelpListItem(
                            title: "orders.rate_service".translate(),
                            description: "orders.share_your_opinion".translate(),
                            svgString: AssetsConst.starSvg,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            onHelpItemPressed: () => _viewController.onServiceRatingPressed(order),
                          ));
                    }),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
