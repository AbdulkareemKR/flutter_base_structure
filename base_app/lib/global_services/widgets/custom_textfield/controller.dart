import 'package:flutter/material.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:garage_client/global_services/widgets/custom_textfield/textfield_types.dart';

class CustomTextFieldWidgetController {
  Color getTextFieldColor(TextFieldType type, bool isValid, bool showValid) {
    if (type == TextFieldType.active) {
      return ServiceProviderColors.consmicCobalt100;
    } else if (isValid) {
      if (showValid) {
        return ServiceProviderColors.positiveGreen;
      } else {
        return Colors.grey;
      }
    } else {
      return ServiceProviderColors.errorRed;
    }
  }
}
