class Validator {
  static bool isValidatePassword(String value) {
    if ((value.length < 6) || value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool isValidateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  static bool isValidPhoneNumber(String value) {
    return value.length == 13 && int.tryParse(value) != null;
  }

  static bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  static bool containsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase().contains(string2.toLowerCase());
  }

  static bool listContainsIgnoreCase(String value, List<String> list) {
    for (var i = 0; i < list.length; i++) {
      if (containsIgnoreCase(list[i], value)) {
        return true;
      }
    }

    return false;
  }

  static bool compareIgnoreCase(String string1, String string2) {
    return string1.toLowerCase() == (string2.toLowerCase());
  }

  static bool safeIsNotEmpty(object) {
    return object != null && object.isNotEmpty && object != '';
  }

  static bool safeListIsNotEmpty(object) {
    return object != null && object.length > 0;
  }

  static String languageStringValidator(String langCode) {
    if (langCode == "ar") {
      return '[\u0621-\u064A0-9 ]|[\r\n]+';
    } else {
      return '[a-zA-Z ]|[\r\n]+';
    }
  }
}
