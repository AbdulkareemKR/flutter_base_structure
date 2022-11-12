import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class HelpListItem extends StatelessWidget {
  final void Function() onHelpItemPressed;
  final String title;
  final String description;
  final String svgString;
  final EdgeInsets padding;

  const HelpListItem({
    Key? key,
    required this.title,
    required this.description,
    required this.onHelpItemPressed,
    required this.svgString,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onHelpItemPressed,
      child: Padding(
        padding: padding,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: SpacingConst.spacing6.w),
          decoration: BoxDecoration(
            borderRadius: smallBorderRadius,
            color: ColorsConst.white,
            boxShadow: [ShadowConst.blackShadow],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: SpacingConst.spacing6.h),
                child: Container(
                  padding: EdgeInsets.all(SpacingConst.spacing6.w),
                  height: 30.w,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    borderRadius: smallBorderRadius,
                    color: ColorsConst.cultured,
                  ),
                  child: SvgPicture.asset(svgString),
                ),
              ),
              SpacingConst.hSpacing6,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textThemes.bodySmall,
                  ),
                  SizedBox(
                    width: 258.w,
                    child: Text(
                      description,
                      style: context.textThemes.caption?.regular.copyWith(color: ColorsConst.lightGrey),
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
