import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/widgets/custom_textfield/textfield_types.dart';

class CustomTextFieldWidgetController {
  Color getTextFieldColor(TextFieldType type, bool isValid, bool showValid) {
    if (type == TextFieldType.active) {
      return ColorsConst.cosmicCobalt;
    } else if (isValid) {
      if (showValid) {
        return ColorsConst.positiveGreen;
      } else {
        return Colors.grey;
      }
    } else {
      return ColorsConst.negativeRed;
    }
  }
}
