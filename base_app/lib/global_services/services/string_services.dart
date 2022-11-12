extension GetCamelCase on String {
  String toCamelCase() {
    final stringArray = split(RegExp(r'[_.-\s]'));
    String camelCaseString = stringArray.first;
    for (final word in stringArray.sublist(1)) {
      camelCaseString += (word[0].toUpperCase() + word.substring(1));
    }
    return camelCaseString;
  }
}
