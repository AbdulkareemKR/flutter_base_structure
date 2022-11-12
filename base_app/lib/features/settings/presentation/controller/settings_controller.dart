import 'package:flutter/material.dart';
import 'package:garage_client/constants/url_const.dart';
import 'package:garage_client/features/orders/presentation/screens/orders_screen.dart';
import 'package:garage_client/features/profile/presentation/screens/profile_screen.dart';
import 'package:garage_client/global_services/services/auth_services.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/bottom_sheet_navigator.dart';

class SettingsController {
  final BuildContext context;

  SettingsController({required this.context});

  void onProfileClick() {
    EasyNavigator.openPage(context: context, page: const ProfileScreen());
  }

  void onSignOutClick() async {
    await FirebaseAuthServices.instance.signOut();

    EasyNavigator.popToFirstView(context);
  }
}
