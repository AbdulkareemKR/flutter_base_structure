import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/widgets/custom_button/custom_button.dart';
import 'package:garage_client/widgets/custom_button/enums/button_style.dart';
import 'package:garage_client/services/easy_navigator.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/sheet.dart';

class NoTimeslotWidget extends StatelessWidget {
  const NoTimeslotWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sheet(
      children: [
        SpacingConst.vSpacing120,
        SvgPicture.asset(
          AssetsConst.searchError,
          height: 167.h,
          width: 149.w,
        ),
        SpacingConst.vSpacing60,
        Text(
          "timeslot.noAvailableTimeslots".translate(),
          style: context.textThemes.titleMedium?.copyWith(color: ColorsConst.cosmicCobalt),
          textAlign: TextAlign.center,
        ),
        SpacingConst.vSpacing8,
        Text(
          "errors.tryAgain".translate(),
          style: context.textThemes.bodyMedium?.copyWith(color: ColorsConst.blackCoral),
          textAlign: TextAlign.center,
        ),
      ],
      footer: [
        Center(
          child: CustomButton(
            label: "orders.checkOtherServices".translate(),
            onPressed: () => EasyNavigator.popToFirstView(context),
            style: CustomButtonStyle.primary,
          ),
        )
      ],
    );
  }
}
