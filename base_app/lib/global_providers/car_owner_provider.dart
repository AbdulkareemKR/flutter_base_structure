import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/models/car_owner.dart';
import 'package:garage_core/services/auth_services.dart';
import 'package:garage_core/services/car_owner_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

var cachedCarOwnerProvider = StreamProvider<CarOwner?>((ref) {
  return Stream.value(null);
});

final carOwnerProvider = StreamProvider<CarOwner?>((ref) {
  return ref.watch(authStreamProvider).when(
        loading: () => Stream.value(null),
        error: ((error, stackTrace) => Stream.value(null)),
        data: (user)  {
          if (user != null) {
            final carOwnerStream = ref.read(carOwnerRepoProvider).getCarOwnerStream(user.uid);
            return carOwnerStream;
          } else {
            return Stream.value(null);
          }
        },
      );
});

final carOwnerStateProvider = StateProvider<CarOwner?>((ref) {
  return ref
      .watch(carOwnerProvider)
      .when(data: (carOwner) => carOwner, error: (error, stack) => null, loading: () => null);
});

final authStreamProvider = StreamProvider<User?>(((ref) => FirebaseAuthServices.authChange));
