import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';

import 'constants.dart';

class AppLocalization {
  late Map<String, dynamic> _localizedValues;
  final Locale locale;

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationsDelegate();

  static AppLocalization? get instance => _AppLocalizationsDelegate.instance;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Future<void> initialize() async {
    final jsonStringValues = await rootBundle.loadString('$languagesPath/${locale.languageCode}.json');
    _localizedValues = json.decode(jsonStringValues);
  }

  String findKey(key) {
    return key.replaceFirst(key[0], key[0].toLowerCase()).replaceAll(" ", "");
  }

  String translate(String key) {
    late String result;
    try {
      if (key.contains('.')) {
        final keys = key.split('.');
        result = keys.length == 2 ? _localizedValues[keys[0]][keys[1]] : _localizedValues[keys[0]][keys[1]][keys[2]];

        return result;
      }
      result = _localizedValues[key];
      return result;
    } catch (err) {
      GLogger.error("Error translating $key \n Key not found");
      return key;
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();

  static AppLocalization? instance;

  @override
  bool isSupported(Locale locale) {
    return supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.initialize();

    instance = localization;

    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
