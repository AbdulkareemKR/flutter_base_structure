import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/booking/presentation/screens/booking_screen_form.dart';
import 'package:garage_client/features/cars/presentation/screens/add_cars_screen.dart';
import 'package:garage_client/features/location/presentation/screens/location_screen.dart';
import 'package:garage_client/features/tracking_order/presentation/screens/tracking_order_screen.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/models/user_car.dart';
import 'package:garage_client/services/auth_services.dart';
import 'package:garage_client/services/firestore_services.dart';
import 'package:garage_client/services/easy_navigator.dart';
import 'package:garage_client/features/settings/presentation/screens/setting_screen.dart';
import 'package:garage_client/widgets/bottom_sheet/bottom_sheet_navigator.dart';

final homeScreenControllerProvider = Provider<HomeScreenController>((ref) {
  return HomeScreenController();
});

class HomeScreenController {
  final PageController pageController = PageController();

  void onAddCarClick(BuildContext context) {
    showCustomBottomSheet(context: context, child: const AddCarsScreen());
  }

  void onCarClick({required BuildContext context, required UserCar car}) {
    showCustomBottomSheet(
        context: context,
        child: AddCarsScreen(
          userCar: car,
        ));
  }

  void onLocationClick(BuildContext context) {
    EasyNavigator.openPage(context: context, page: const LocationScreen(), isAnimated: false, isCupertinoStyle: false);
  }

  void onProfileClick(BuildContext context) {
    // TODO: handle profile click
    showCustomBottomSheet(context: context, child: const SettingsScreen(), applyPadding: false);
  }

  void onServiceClick(Service service, BuildContext context) {
    showCustomBottomSheet(context: context, child: BookingScreenFrom(service: service));
  }

  void onWalletClick() {
    //TODO: handle wallet click
  }

  void onActiveOrderClick(BuildContext context, String orderId) {
    EasyNavigator.openPage(context: context, page: TrackingOrderScreen(orderId: orderId));
  }

  Future<void> setDefaultCar(UserCar? car) async {
    if (car != null) {
      await FirestoreServices.carOwnersCollection
          .doc(FirebaseAuthServices.instance.currentUser?.uid)
          .update({'defaultCar': car.toMap()});
    }
  }
}
