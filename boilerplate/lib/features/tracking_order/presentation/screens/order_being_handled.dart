import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class OrderBeingHandled extends StatelessWidget {
  const OrderBeingHandled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacingConst.vSpacing70,
        SizedBox(
          height: 200.h,
          child: SvgPicture.asset(AssetsConst.technicianCleaningCar),
        ),
        SpacingConst.vSpacing96,
        SizedBox(
          width: 279.w,
          child: Text(
            "orders.service_provider_started_working".translate(),
            style: context.textThemes.titleMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
