import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:garage_client/widgets/bottom_sheet/src.dart';
import 'package:garage_client/widgets/bottom_sheet/utils/bottom_sheet_wrapper.dart';

class EasyNavigator {
  static Future<T?> openPage<T>({
    required BuildContext context,
    required Widget page,
    bool isAnimated = false,
    bool isPushReplaced = false,
    bool isPushAndRemoveUntil = false,
    bool isCupertinoStyle = true,
    bool isDismissible = true,
    bool expand = true,
  }) async {
// It's just a check to make sure that you can't set isCupertinoStyle to true and isPushReplaced or
// isPushAndRemoveUntil to true, you should set only one of them to true.
    if ((isPushReplaced || isPushAndRemoveUntil) && isCupertinoStyle) {
      log("(EasyNavigator): Can't set [isCupertinoStyle = true] and [isPushReplaced or isPushAndRemoveUntil = true], you should set only one of them to true\nSetting isCupertinoStyle to `false`");
      isCupertinoStyle = false;
    }

    if (kIsWeb) {
      log("(EasyNavigator): Can't set [isCupertinoStyle = true] in web mode");
      isCupertinoStyle = false;
    }

    // Screens
    if (isCupertinoStyle) {
      return await showCupertinoModalBottomSheet<T>(
        expand: expand,
        isDismissible: isDismissible,
        duration: const Duration(milliseconds: 300),
        // settings: RouteSettings(arguments: {'isAnimated': isAnimated}),
        context: context,

        builder: (context) {
          return BottomSheetWrapper(body: page);
        },
      );
    } else {
      // Push

      if (isPushAndRemoveUntil) {
        return await Navigator.of(context).pushAndRemoveUntil<T>(
            MaterialWithModalsPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
      }

      if (isPushReplaced) {
        return await Navigator.of(context)
            .pushReplacement(AnimatedMaterialWithModalsPageRoute(builder: (context) => page));
      }

      if (!isAnimated) {
        return await Navigator.of(context, rootNavigator: true).push<T>(MaterialWithModalsPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => page,
        ));
      } else if (isAnimated) {
        return await Navigator.of(context).push<T>(AnimatedMaterialWithModalsPageRoute(builder: (context) => page));
      }
    }
    return null;
  }

  /// Pop the view to the root view
  static void popToFirstView(BuildContext context) {
    GLogger.debug("Pop to first view");
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static Future<void> popPage(context, {args}) async {
    await Navigator.maybePop(context, args);
  }
}
