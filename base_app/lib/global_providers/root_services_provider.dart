import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/service.dart';
import 'package:garage_client/global_services/services/services_repo.dart';

final rootServicesProvider = FutureProvider<List<Service>>((ref) async {
  return ref.read(servicesRepoProvider).getRootServices();
});
