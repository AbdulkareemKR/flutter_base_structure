import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/widgets/order_container.dart';
import 'package:garage_client/global_providers/orders_provider.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';

class OrderAccepted extends ConsumerStatefulWidget {
  const OrderAccepted({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<OrderAccepted> createState() => _OrderAcceptedState();
}

class _OrderAcceptedState extends ConsumerState<OrderAccepted> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing16.w),
        child: Consumer(
          builder: ((context, ref, child) {
            return ref.watch(activeOrderStream).build((order) {
              return Column(
                children: [
                  SpacingConst.vSpacing70,
                  SizedBox(
                    height: 200.h,
                    child: SvgPicture.asset(AssetsConst.manWithComputer),
                  ),
                  SpacingConst.vSpacing96,
                  Text(
                    "orders.order_accepted".translate(),
                    style: context.textThemes.titleMedium,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SpacingConst.vSpacing16,
                  Row(
                    children: [
                      OrderContainer(
                        height: 55.h,
                        width: 334.w,
                        titleWidget: Text(
                          "orders.service_provider".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        ),
                        contentWidget: ref.watch(orderServiceProvider(order)).build(
                              (serviceProvider) => Text(
                                serviceProvider?.name.translated ?? "",
                                style: context.textThemes.bodyMedium,
                              ),
                            ),
                      ),
                    ],
                  ),
                  SpacingConst.vSpacing8,
                  Row(
                    children: [
                      OrderContainer(
                        width: 163.w,
                        height: 55.h,
                        titleWidget: Text(
                          "orders.location".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        ),
                        contentWidget: Text(
                          order?.location.title ?? "",
                          style: context.textThemes.bodyMedium,
                        ),
                      ),
                      SpacingConst.hSpacing8,
                      OrderContainer(
                        width: 163.w,
                        height: 55.h,
                        titleWidget: Text(
                          "orders.payment_method_title".translate(),
                          style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                        ),
                        contentWidget: Text(
                          "paymentMethod.${order?.transaction?.paymentMethod.name ?? "notPaid"}".translate(),
                          style: context.textThemes.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            });
          }),
        ));
  }
}
