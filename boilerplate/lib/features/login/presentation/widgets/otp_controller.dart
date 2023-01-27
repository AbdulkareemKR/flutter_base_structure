import 'package:flutter/material.dart';

class OTPFieldController {
  static void handleChangeFocus({
    required TextEditingController controller,
    required BuildContext context,
    required void Function() callback,
    required List<FocusNode> focusNodes,
    required int fieldIndex,
  }) {
    if (controller.text.length > 1) {
      if (fieldIndex >= focusNodes.length - 1) {
        FocusScope.of(context).unfocus();
        callback();
      } else {
        if (controller.text.split('').last != "\u200b") {
          controller.text = controller.text.split('').last;
        }
        FocusScope.of(context).nextFocus();
      }
    } else {
      if (fieldIndex != 0) {
        FocusScope.of(context).previousFocus();
      }
    }
  }

  static void handleEmptyText(TextEditingController controller) {
    if (controller.text.isEmpty) {
      controller.text = "\u200b";
    }
  }
}
