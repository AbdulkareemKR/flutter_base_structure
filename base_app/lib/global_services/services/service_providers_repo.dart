import 'dart:developer';
import 'package:garage_client/global_services/models/serivce_provider.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      log('$e');
      ;
    }
    return null;
  }

  Future<void> updateServiceProviderDocument(ServiceProvider serviceProvider) async {
    (firestoreRepo.serviceProvidersCollection.doc(serviceProvider.uid).update(serviceProvider.toMap()).then(
        (value) => log("services has been updated successfully!"),
        onError: (e) => log("Error updating document $e")));
  }
}
