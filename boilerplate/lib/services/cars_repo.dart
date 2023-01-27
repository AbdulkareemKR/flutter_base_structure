import 'package:garage_client/models/car.dart';
import 'package:garage_client/models/translatable.dart';
import 'package:garage_client/services/firestore_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

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
      GLogger.warning('The car dose not exist!');
      e.logException();
      return null;
    }
    return null;
  }
}
