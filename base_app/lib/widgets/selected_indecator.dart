import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';

class SelectedIndicator extends StatelessWidget {
  const SelectedIndicator({
    Key? key,
    required this.selected,
    required this.count,
  }) : super(key: key);

  final int selected;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          count,
          (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                width: index == selected ? 8.h : 17.w,
                height: 8.h,
                decoration: BoxDecoration(
                    color: index == selected ? ColorsConst.cosmicCobalt : ColorsConst.disableGrey,
                    borderRadius: BorderRadius.circular(8.h)),
              )),
    );
  }
}
