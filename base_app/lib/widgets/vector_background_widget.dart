import 'package:flutter/material.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VectorBackgroundWidget extends StatelessWidget {
  const VectorBackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 100.w,
          top: -10.h,
          child: Image.asset(AssetsConst.leftTopBackgroundImage),
        ),
        Positioned(
          right: 0,
          top: 50.h,
          child: Image.asset(AssetsConst.rightBackgroundImage),
        ),
        Positioned(
          right: 230.w,
          top: 25.h,
          child: Image.asset(AssetsConst.leftBackgroundImage),
        ),
      ],
    );
  }
}
