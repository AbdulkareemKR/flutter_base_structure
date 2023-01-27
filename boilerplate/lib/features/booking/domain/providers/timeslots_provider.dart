import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/models/serivce_provider.dart';
import 'package:garage_client/models/timeslot.dart';
import 'package:garage_client/services/timeslots_services.dart';


/// It is used to filter timeslots for other services
final validServiceProvidersProvider = StateProvider<List<ServiceProvider>>((ref) {
  return [];
});
