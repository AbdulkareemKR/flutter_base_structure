import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/models/car.dart';
import 'package:garage_core/models/translatable.dart';
import 'package:garage_core/services/car_services.dart';

final carsProvider = FutureProvider<Map<Translatable, List<Car>>>((ref) async {
  final cars = await getConstCars();
  return groupCarsByCompany(cars);
});
