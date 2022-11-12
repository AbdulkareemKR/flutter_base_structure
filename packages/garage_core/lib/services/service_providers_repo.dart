import 'dart:developer';
import 'package:garage_core/models/serivce_provider.dart';
import 'package:garage_core/services/firestore_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';


final serviceProviderRepoProvider = Provider<ServiceProvidersRepo>(
  (ref) => ServiceProvidersRepo(
    firestoreRepo: ref.watch(firestoreRepoProvider),
  ),
);

class ServiceProvidersRepo {
  ServiceProvidersRepo({required this.firestoreRepo});
  FirestoreRepo firestoreRepo;

  Future<ServiceProvider?> getServiceProviderFromUid(String uid) async {
    try {
      final serviceProviderData = (await firestoreRepo.serviceProvidersCollection.doc(uid).get()).data();
      if (serviceProviderData != null) {
        final serviceProvider = ServiceProvider.fromMap(serviceProviderData);
        return serviceProvider;
      }
    } catch (e) {
      e.logException();
    }
    return null;
  }

  Future<void> updateServiceProviderDocument(ServiceProvider serviceProvider) async {
    (firestoreRepo.serviceProvidersCollection.doc(serviceProvider.uid).update(serviceProvider.toMap()).then(
        (value) => log("services has been updated successfully!"),
        onError: (e) => log("Error updating document $e")));
  }
}
