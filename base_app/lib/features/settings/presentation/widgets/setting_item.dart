import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconColor = ColorsConst.cosmicCobalt,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final void Function() onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        HapticFeedback.mediumImpact();
        onTap();
      }),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 7.w),
        child: Row(children: [
          SpacingConst.hSpacing8,
          Container(
            child: Icon(
              icon,
              size: 15.sp,
              color: iconColor,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.sp),
              color: ColorsConst.cultured,
            ),
            width: 30.w,
            height: 30.w,
          ),
          SpacingConst.hSpacing16,
          Text(
            text,
            style: context.textThemes.bodySmall,
          )
        ]),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        width: 311.w,
        height: 48.h,
        decoration: BoxDecoration(
            color: ColorsConst.white,
            boxShadow: [BoxShadow(color: ColorsConst.black.withOpacity(0.08), blurRadius: 10)],
            borderRadius: BorderRadius.circular(14.sp)),
      ),
    );
  }
}
