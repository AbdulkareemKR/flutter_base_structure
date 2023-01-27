import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/models/car.dart';
import 'package:garage_client/models/translatable.dart';
import 'package:garage_client/services/car_services.dart';

final carsProvider = FutureProvider<Map<Translatable, List<Car>>>((ref) async {
  final cars = await getConstCars();
  return groupCarsByCompany(cars);
});
