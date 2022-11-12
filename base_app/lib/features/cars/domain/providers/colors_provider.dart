


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/models/color.dart';
import 'package:garage_core/services/car_services.dart';

final colorsProvider = FutureProvider<List<CarColor>>((ref) async {
  return getConstColors();
});