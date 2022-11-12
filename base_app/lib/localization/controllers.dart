import 'package:flutter/widgets.dart';
import 'package:garage_client/constants/icons/garage_icons.dart';
import 'package:garage_client/localization/app_localization.dart';
import 'package:garage_client/global_services/services/validator.dart';

String translate(String key, {List<String> arguments = const []}) {
  if (Validator.safeListIsNotEmpty(arguments)) {
    String baseText = AppLocalization.instance?.translate(key) ?? key;
    for (int i = 0; i < arguments.length; i++) {
      baseText = baseText.replaceFirst("^[]", arguments[i]);
    }
    return baseText;
  } else {
    return AppLocalization.instance?.translate(key) ?? key;
  }
}

bool isArabic(BuildContext context) {
  return (AppLocalization.of(context)?.locale.languageCode == 'ar' ? true : false);
}

Alignment customAlignment(context, {bool flip = false, top = false, bottom = false}) {
  if (top) {
    if (flip) {
      return isArabic(context) ? Alignment.topLeft : Alignment.topRight;
    } else {
      return isArabic(context) ? Alignment.topRight : Alignment.topLeft;
    }
  } else if (bottom) {
    if (flip) {
      return isArabic(context) ? Alignment.bottomLeft : Alignment.bottomRight;
    } else {
      return isArabic(context) ? Alignment.bottomRight : Alignment.bottomLeft;
    }
  } else if (flip) {
    return isArabic(context) ? Alignment.centerLeft : Alignment.centerRight;
  } else {
    return isArabic(context) ? Alignment.centerRight : Alignment.centerLeft;
  }
}

IconData arrowBackward(BuildContext context) {
  return isArabic(context) ? GarageIcons.Arrow_Right : GarageIcons.Arrow_Left;
}

IconData arrowForward(BuildContext context) {
  return isArabic(context) ? GarageIcons.Arrow_Left : GarageIcons.Arrow_Right;
}
