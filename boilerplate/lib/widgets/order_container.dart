import 'package:flutter/material.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderContainer extends StatelessWidget {
  final Widget titleWidget;
  final Widget? contentWidget;
  final double? height;
  final double? width;

  const OrderContainer({
    Key? key,
    required this.titleWidget,
    this.contentWidget,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: SpacingConst.spacing16.w,
        vertical: SpacingConst.spacing6.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusConst.smallBorderRadius,
        border: Border.all(
          color: ColorsConst.disableGrey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget,
          contentWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
