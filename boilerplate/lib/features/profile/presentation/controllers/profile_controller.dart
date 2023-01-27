import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/services/car_owner_repo.dart';

final profileStateProvider = StateNotifierProvider<ProfileStateNotifier, AsyncValue<void>>((ref) {
  return ProfileStateNotifier(ref: ref);
});

class ProfileStateNotifier extends StateNotifier<AsyncValue<void>> {
  ProfileStateNotifier({required this.ref}) : super(const AsyncData(null)) {
    init();
  }
  final Ref ref;

  late String userName;
  late String uid;
  late String userPhoneNumber;
  final TextEditingController nameController = TextEditingController();

  void init() {
    state = const AsyncLoading();

    ref.watch(carOwnerProvider).whenData((carOwnerData) {
      userName = carOwnerData?.name ?? '';
      uid = carOwnerData?.uid ?? '';
      nameController.text = userName;
      userPhoneNumber = carOwnerData?.phoneNumber ?? '';
      state = const AsyncData(null);
    });
  }

  Future<void> onSavePress(BuildContext context) async {
    await ref.read(carOwnerRepoProvider).changeUserName(uid, nameController.text);
    Navigator.of(context).pop();
  }
}
