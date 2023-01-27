import 'package:flutter/material.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/tracking_order/domain/providers/order_rating_notifier.dart';
import 'package:garage_client/features/tracking_order/presentation/controllers/tracking_order_controller.dart';
import 'package:garage_client/features/tracking_order/presentation/widgets/note_text_field.dart';
import 'package:garage_client/features/tracking_order/presentation/widgets/star_rating.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garage_client/models/order.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';

class OrderCompleted extends ConsumerStatefulWidget {
  const OrderCompleted({required this.order, Key? key}) : super(key: key);
  final Order order;

  @override
  ConsumerState<OrderCompleted> createState() => _OrderCompletedState();
}

class _OrderCompletedState extends ConsumerState<OrderCompleted> {
  late final TrackingOrderController _viewController = TrackingOrderController(context: context, ref: ref);

  @override
  void initState() {
    Future.microtask(() {
      ref.read(orderRatingProvider.notifier).updateOrderId(widget.order.id ?? "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.8.sh,
      child: Sheet(
        children: [
          SpacingConst.vSpacing70,
          SizedBox(
            height: 200.h,
            child: SvgPicture.asset(AssetsConst.orderCompleted),
          ),
          SpacingConst.vSpacing20,
          Text(
            "orders.service_provider_finished".translate(),
            style: context.textThemes.titleMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SpacingConst.vSpacing16,
          Directionality(
            textDirection: TextDirection.ltr, //FIXME
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "poor".translate(),
                  style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.lightGrey),
                ),
                SpacingConst.hSpacing8,
                StarRating(
                  color: ColorsConst.warningYellow,
                  rating: ref.watch(orderRatingProvider)!.rating!,
                  changeRatingHandler: _viewController.onChangeRating,
                ),
                SpacingConst.hSpacing8,
                Text(
                  "excellent".translate(),
                  style: context.textThemes.bodySmall?.copyWith(color: ColorsConst.lightGrey),
                ),
              ],
            ),
          ),
          SpacingConst.vSpacing20,
          Container(
            height: 151.h,
            width: 330.w,
            padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing20.w, vertical: SpacingConst.spacing6.h),
            decoration: BoxDecoration(
              boxShadow: [ShadowConst.blackShadow],
              color: ColorsConst.white,
              borderRadius: BorderRadiusConst.smallBorderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "orders.notes".translate(),
                  style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.dartGrey),
                ),
                SpacingConst.vSpacing8,
                Center(
                  child: SizedBox(
                    width: 288.w,
                    height: 101.h,
                    child: NoteTextField(viewController: _viewController),
                  ),
                ),
              ],
            ),
          ),
          SpacingConst.vSpacing40,
          CustomButton(
            label: "orders.send_button".translate(),
            onPressed: _viewController.ratingSubmitHandler,
            style: CustomButtonStyle.secondary,
            width: 230.w,
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
