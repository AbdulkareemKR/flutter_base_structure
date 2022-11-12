import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/color.dart';
import 'package:garage_client/global_services/services/car_services.dart';

final colorsProvider = FutureProvider<List<CarColor>>((ref) async {
  return getConstColors();
});
