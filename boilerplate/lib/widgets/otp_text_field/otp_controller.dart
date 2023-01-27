import 'package:flutter/material.dart';

class OTPFieldController {
  static String handleChangeFocus({
    required String currentText,
    required BuildContext context,
    required void Function() callback,
    required List<FocusNode> focusNodes,
    required int fieldIndex,
  }) {
    if (currentText.isNotEmpty) {
      if (fieldIndex >= focusNodes.length - 1) {
        FocusScope.of(context).unfocus();
        callback();
      } else {
        if (currentText.split('').isNotEmpty) {
          currentText = currentText.split('').last;
        }
        FocusScope.of(context).nextFocus();
      }
    } else {
      if (fieldIndex != 0) {
        FocusScope.of(context).previousFocus();
      }
    }

    return currentText;
  }

  static void handleEmptyText(TextEditingController controller) {
    if (controller.text.isEmpty) {
      controller.text = "\u200b";
    }
  }
}
