import 'package:flutter/material.dart';
import 'package:garage_client/utils/theme/themes.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';
import 'package:riverpod/riverpod.dart';

class ThemeManager extends StateNotifier<ThemeData> {
  ThemeManager(ThemeData state) : super(state);

  static final StateNotifierProvider<ThemeManager, ThemeData> themeProvider =
      StateNotifierProvider((ref) => ThemeManager(currentThemeData));

  // Default theme
  static ThemeData currentThemeData = GarageThemes.main;

  /// Change the current app theme to the passed [ThemeData]
  void changeTheme(ThemeData theme) {
    currentThemeData = theme;

    state = currentThemeData;

    GLogger.info('Theme is changed');
  }
}
