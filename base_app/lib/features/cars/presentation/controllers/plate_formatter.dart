import 'package:flutter/services.dart';
import 'package:garage_core/models/plate.dart';

class PlateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(' ', '');

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if ((Plate.translatableLetters.keys.contains(text[i].toUpperCase())) ||
          (Plate.translatableLetters.values.contains(text[i].toUpperCase()))) {
        buffer.write(text[i].toUpperCase());
        if (i != text.length - 1) {
          buffer.write(' ');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}
