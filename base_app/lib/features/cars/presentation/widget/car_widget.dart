import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_core/models/color.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);
  final bool isSelected;
  final CarColor color;
  final void Function(CarColor color) onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(color);
      },
      child: Column(
        children: [
          Container(
            height: 32.w,
            width: 32.w,
            decoration: BoxDecoration(
                color: Color(int.parse(color.hexCode)),
                borderRadius: BorderRadius.all(Radius.circular(32.w)),
                border: Border.all(
                    width: isSelected ? 3 : 1,
                    color: isSelected ? ColorsConst.cosmicCobalt.shade300 : ColorsConst.lightGrey)),
          ),
          //TODO : use local
          Text(
            color.title.translated,
            style: context.textThemes.displaySmall?.regular.copyWith(fontSize: 10.sp),
            maxLines: 1,
            softWrap: false,
          )
        ],
      ),
    );
  }
}
