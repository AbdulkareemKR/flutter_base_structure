import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/home/presentation/screens/home_screen.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'dart:developer';

class SplashScreenController {
  BuildContext context;
  WidgetRef ref;

  SplashScreenController({
    required this.context,
    required this.ref,
  });

  void _navigateToHome() async {
    EasyNavigator.openPage(context: context, page: const HomeScreen(), isCupertinoStyle: false, isPushReplaced: true);
  }

  /// This method checks if the [Initializer] is done, if so then it navigate to [HomePage]
  void checkInitialization({required AsyncSnapshot<Object?> snapshot}) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        Future.microtask(() => _navigateToHome());
        break;

      default:
        log('snapshot type: ${snapshot.connectionState}');
    }
  }
}
