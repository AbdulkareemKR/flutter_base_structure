import 'package:flutter/material.dart';
import 'package:garage_client/constants/url_const.dart';
import 'package:garage_client/features/cars/presentation/screens/cars_lits_screen.dart';
import 'package:garage_client/features/orders/presentation/screens/orders_screen.dart';
import 'package:garage_client/features/profile/presentation/screens/profile_screen.dart';
import 'package:garage_client/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:garage_client/global_services/services/auth_services.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/bottom_sheet_navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController {
  final BuildContext context;

  SettingsController({required this.context});

  void onOrdersClick() {
    showCustomBottomSheet(context: context, child: const OrdersScreen());
  }

  void onWalletClick() {
    EasyNavigator.openPage(context: context, page: WalletScreen());
  }

  void onCarsClick() {
    showCustomBottomSheet(context: context, child: const CarsListScreen());
  }

  void onProfileClick() {
    showCustomBottomSheet(context: context, child: const ProfileScreen());
  }

  void onGiftClick() {
    //TODO: handle onGiftClick
  }
  void onCouponsClick() {
    //TODO: handle onCouponsClick
  }
  void onHelpClick() {
    //TODO: handle onHelpClick
  }
  void onTermsClick() {
    launchUrl(Uri.parse(UrlConst.termsAndConditions));
  }

  void onSignOutClick() async {
    await FirebaseAuthServices.instance.signOut();

    EasyNavigator.popToFirstView(context);
  }
}
