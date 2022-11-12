import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/login/presentation/screens/login_screen.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/global_services/services/easy_navigator.dart';

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
          EasyNavigator.openPage(context: context, page: const LoginScreen());
        } else {
          onTap();
        }
      },
      child: child,
    );
  }
}
