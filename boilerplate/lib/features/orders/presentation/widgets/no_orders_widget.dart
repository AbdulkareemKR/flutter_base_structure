import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';

class NoOrdersWidget extends StatelessWidget {
  final void Function() onButtonPressed;

  const NoOrdersWidget({required this.onButtonPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacingConst.vSpacing120,
        SvgPicture.asset(
          AssetsConst.searchError,
          height: 167.h,
          width: 149.w,
        ),
        SpacingConst.vSpacing60,
        Text(
          "orders.ordersHistoryEmpty".translate(),
          style: context.textThemes.titleMedium?.copyWith(color: ColorsConst.cosmicCobalt),
        ),
        SpacingConst.vSpacing8,
        Text(
          "orders.youDidNotTryOurService".translate(),
          style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.blackCoral),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: CustomButton(
            label: "orders.showServices".translate(),
            onPressed: onButtonPressed,
            style: CustomButtonStyle.primary,
          ),
        )
      ],
    );
  }
}
