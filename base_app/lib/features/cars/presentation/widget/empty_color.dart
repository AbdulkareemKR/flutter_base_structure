import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';

class EmptyColor extends StatelessWidget {
  const EmptyColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 32.w,
          width: 32.w,
          decoration: BoxDecoration(
            color: ColorsConst.white,
            borderRadius: BorderRadius.all(Radius.circular(32.w)),
          ),
        ),
        const Text(
          '',
        )
      ],
    );
  }
}
