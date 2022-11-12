import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/orders/presentation/screens/orders_screen.dart';
import 'package:garage_client/widgets/animated_dialog.dart';
import 'package:garage_client/global_services/services/auth_services.dart';
import 'package:garage_client/features/login/domain/auth_reoo.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'package:garage_client/localization/extensions.dart';

/// This class is responsible for the login screen logic
/// it will handle the login process and navigate to the home screen
class LoginScreenController {
  BuildContext context;
  WidgetRef ref;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreenController({
    required this.context,
    required this.ref,
  });

  /// This method will be called from onLoginPressed method to login the user
  /// It will call the [FirebaseAuthServices] to sign in the user
  Future<void> login() async {
    /**
     * First we check that the user entered a valid email and password
     */
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // If not throw error that will be handled in the widget
      throw Exception('Please enter email and password');
    }
    final user = await ref.read(authRepo).singInWithEmail(emailController.text, passwordController.text);
    if (user != null) {
      // If everything went good this means successful login
      log("Successfully logged in with UId: ${user.uid}");
    } else {
      // else throw error that will be handled in the widget
      throw Exception('Invalid email or password');
    }
  }

  /// This function will handle the log in button from the UI
  Future<void> onLoginPressed() async {
    try {
      await login();

      // If everything went good and the user was logged in
      EasyNavigator.openPage(context: context, page: const OrdersScreen(), isPushReplaced: true);
    } catch (e) {
      // If the user enters invalid email/password, we will show an error dialog
      log(e.toString());
      GarageDialog.show(context: context, style: DialogStyle.error, message: 'invalid_credentials'.translate());
    }
  }
}
