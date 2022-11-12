class DoubleServices {
  static num getFractionPart(num number) {
    final int integerPart = number.toInt();
    return number - integerPart;
  }

  static String getFractionString(num number) {
    return '.' + DoubleServices.getFractionPart(number).toStringAsFixed(2).split('.').last;
  }
}
