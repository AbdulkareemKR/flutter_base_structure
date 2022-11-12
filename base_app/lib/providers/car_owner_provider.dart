import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/car_owner.dart';
import 'package:garage_client/global_services/services/auth_services.dart';
import 'package:garage_client/global_services/services/car_owner_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

final carOwnerProvider = StateNotifierProvider<CarOwnerNotifier, CarOwner?>((ref) {
  final carOwnerId = ref.watch(authStreamProvider).when(
        loading: () => null,
        error: ((error, stackTrace) => null),
        data: (user) => user?.uid,
      );
  return CarOwnerNotifier(null, ref: ref, carOwnerRepo: ref.watch(carOwnerRepoProvider), carOwnerId: carOwnerId);
});
final authStreamProvider = StreamProvider<User?>(((ref) => FirebaseAuthServices.authChange));

class CarOwnerNotifier extends StateNotifier<CarOwner?> {
  CarOwnerNotifier(CarOwner? state, {required this.ref, this.carOwnerId, required this.carOwnerRepo}) : super(state) {
    init();
  }

  final Ref ref;
  String? carOwnerId;
  CarOwnerRepo carOwnerRepo;

  Future<void> init() async {
    if (carOwnerId != null) {
      final carOwner = await ref.watch(carOwnerRepoProvider).getCarOwnerFromId(carOwnerId!);
      state = carOwner;
    } else {
      state = null;
    }
  }
}
