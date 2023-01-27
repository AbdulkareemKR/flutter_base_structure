


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/models/color.dart';
import 'package:garage_client/services/car_services.dart';

final colorsProvider = FutureProvider<List<CarColor>>((ref) async {
  return getConstColors();
});