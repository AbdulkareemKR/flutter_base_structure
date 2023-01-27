import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/services/cars_repo.dart';
import 'package:garage_client/utils/logger/extensions.dart';
import 'package:garage_client/localization/extensions.dart';

final carNameProvider = FutureProvider.family<String, String?>((ref, carId) async {
  try {
    final car = await ref.read(carsRepoProvider).getCarFromId(carId);
    if (car == null) {
      throw Exception();
    }
    final carCompany = '${car.company.translated} ${car.brand.translated} ';
    return carCompany;
  } catch (e) {
    e.logException();
    return '';
  }
});
