import 'package:flutter/services.dart';

class PlateNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final numbersMap = {
      '١': "1",
      '٢': "2",
      '٣': "3",
      '٤': "4",
      '٥': "5",
      '٦': "6",
      '٧': "7",
      '٨': "8",
      '٩': "9",
      '٠': "0",
    };
    var text = newValue.text.replaceAll(' ', '');

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (numbersMap.containsKey(text[i])) {
        buffer.write(numbersMap[text[i]]);
      } else if (numbersMap.values.contains(text[i])) {
        buffer.write(text[i]);
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}
