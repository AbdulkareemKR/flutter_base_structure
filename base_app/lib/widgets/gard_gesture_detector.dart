import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/cars/presentation/screens/add_cars_screen.dart';
import 'package:garage_client/features/loaction/presentation/screens/location_screen.dart';
import 'package:garage_client/features/login/presentation/screens/login_screen.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_core/services/easy_navigator.dart';
import 'package:garage_core/widgets/bottom_sheet/bottom_sheet_navigator.dart';

class GuardGestureDetector extends ConsumerWidget {
  const GuardGestureDetector({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final carOwner = ref.read(carOwnerProvider).asData?.value;

        if (carOwner == null) {
          showCustomBottomSheet(context: context, child: const LoginScreen());
        } else if (carOwner.defaultCar == null) {
          showCustomBottomSheet(context: context, child: const AddCarsScreen());
        } else if (carOwner.defaultLocation == null) {
          EasyNavigator.openPage(
              context: context, page: const LocationScreen(), isAnimated: false, isCupertinoStyle: false);
        } else {
          onTap();
        }
      },
      child: child,
    );
  }
}
