import 'dart:developer';

import 'package:garage_client/global_services/models/car.dart';
import 'package:garage_client/global_services/models/translatable.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carsRepoProvider = Provider<CarsRepo>(
  (ref) => CarsRepo(ref.watch(firestoreRepoProvider)),
);

class CarsRepo {
  final FirestoreRepo firestoreRepo;

  CarsRepo(this.firestoreRepo);

  Future<Car?> getCarFromId(String? carId) async {
    if (carId == null) {
      return null;
    }
    try {
      final carData = (await firestoreRepo.carsCollection.doc(carId).get()).data();
      if (carData != null) {
        final car = Car.fromMap(carData);
        return car;
      }
    } catch (e) {
      log('The car dose not exist!');
      log('$e');
      ;
      return null;
    }
    return null;
  }
}
