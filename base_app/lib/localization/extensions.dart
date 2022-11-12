import 'package:garage_client/app.dart';
import 'package:garage_client/global_services/models/translatable.dart';

import 'controllers.dart' as controller;

extension StringTranslation on String {
  String translate({List<String> arguments = const [], String? parent}) {
    return parent != null
        ? controller.translate('$parent.$this', arguments: arguments)
        : controller.translate(this, arguments: arguments);
  }
}

extension TranslateTranslatable on Translatable {
  String get translated => App.currentLocale.languageCode == 'ar' ? ar : en;
}
