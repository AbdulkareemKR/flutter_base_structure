import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/data/repos/auth_repo.dart';
import 'package:garage_client/models/user_car.dart';
import 'package:garage_client/services/car_services.dart';

final userCarsProvider = StreamProvider<List<UserCar>>((ref) {
  return ref.watch(currentUserStreamProvider).maybeWhen(
        orElse: (() => Stream.value([])),
        data: (data) {
          if (data == null) {
          return  Stream.value([]);
          }
          return getUserCarsStream(data.uid);
        },
      );
});
