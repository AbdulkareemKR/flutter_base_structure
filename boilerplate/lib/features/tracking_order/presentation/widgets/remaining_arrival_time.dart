import 'package:flutter/material.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/services/google_map_direction_services/polyline_result.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class RemainingArrivalTime extends StatelessWidget {
  final PolylineResult? directionResult;
  const RemainingArrivalTime({
    Key? key,
    required this.directionResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return directionResult != null
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: SpacingConst.spacing6.w, vertical: 2.h),
            margin: EdgeInsets.all(SpacingConst.spacing6.h),
            decoration:  BoxDecoration(borderRadius: BorderRadiusConst.smallBorderRadius, color: ColorsConst.white),
            child: Text(
              "location.timeToArrive".translate(arguments: [directionResult!.duration]),
              style: context.textThemes.caption,
            ))
        : const SizedBox.shrink();
  }
}
