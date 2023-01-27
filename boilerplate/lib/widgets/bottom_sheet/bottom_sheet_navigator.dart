import 'package:flutter/material.dart';
import 'package:garage_client/services/easy_navigator.dart';

@Deprecated("Use [EasyNavigator.openPage] instead")
Future<T?> showCustomBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  ScrollPhysics? scrollPhysics,
  bool isDismissible = true,
  bool showCancelButton = false,
  bool applyPadding = true,
  bool isFullBottomSheet = true,
  Color barrierColor = Colors.black54,
}) async {
  return await EasyNavigator.openPage(
      context: context, page: child, isDismissible: isDismissible, expand: isFullBottomSheet);
}
