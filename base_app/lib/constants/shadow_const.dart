import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';

class ShadowConst {
  static final blackShadow = BoxShadow(
    color: ColorsConst.black.withOpacity(0.1),
    blurRadius: 15,
  );
}
