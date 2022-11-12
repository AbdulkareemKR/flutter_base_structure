import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRequested extends StatelessWidget {
  const OrderRequested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacingConst.vSpacing70,
        SizedBox(
          height: 200.h,
          child: SvgPicture.asset(AssetsConst.orderRequested),
        ),
        SpacingConst.vSpacing96,
        Text(
          "orders.ordered_successfully".translate(),
          style: context.textThemes.titleMedium,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
