import 'package:flutter/widgets.dart';

class KeyboardHelper {
  /// Check if the keyboard is currently active or not
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }
}
