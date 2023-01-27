import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/colors_const.dart';

class SettingBox extends StatelessWidget {
  const SettingBox({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        HapticFeedback.mediumImpact();
        onTap();
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.19.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30.r,
                width: 30.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusConst.smallBorderRadius,
                  color: ColorsConst.cultured,
                ),
                child: Icon(
                  icon,
                  color: ColorsConst.cosmicCobalt,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(text)
            ]),
        width: 109.w,
        height: 88.h,
        decoration: BoxDecoration(color: ColorsConst.white, borderRadius: BorderRadius.circular(13.sp)),
      ),
    );
  }
}
