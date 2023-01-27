import 'dart:developer';

import 'package:garage_client/models/order.dart';
import 'package:garage_client/models/tech_account.dart';
import 'package:garage_client/models/technician.dart';
import 'package:garage_client/services/cloud_functions_services.dart';
import 'package:garage_client/services/firestore_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

final technicianRepoProvider =
    Provider<TechnicianRepo>(((ref) => TechnicianRepo(firestoreRepo: ref.watch(firestoreRepoProvider))));

final technicianNameProvider = FutureProvider.family<String?, String>((ref, technicianId) async {
  return await ref.read(technicianRepoProvider).getTechnicianNameFromUid(technicianId);
});

class TechnicianRepo {
  TechnicianRepo({required this.firestoreRepo});
  FirestoreRepo firestoreRepo;

  Future<String?> getTechnicianNameFromUid(String uid) async {
    try {
      final technicianData = (await firestoreRepo.techniciansCollection.doc(uid).get()).data();

      if (technicianData != null) {
        final technician = Technician.fromMap(technicianData);

        return technician.name;
      } else {
        return null;
      }
    } catch (e) {
      e.logException();
    }
    return null;
  }

  Stream<List<Technician>> getTechnicianStreamForServiceProviderId(String serviceProviderId) {
    try {
      final technicianStream = firestoreRepo.techniciansCollection
          .where('serviceProviderId', isEqualTo: serviceProviderId)
          .snapshots()
          .map((list) {
        final techList = list.docs.map((doc) => Technician.fromMap(doc.data())).toList();
        techList.removeWhere((technician) => technician.isDeleted);
        return techList;
      });
      return technicianStream;
    } catch (e) {
      log(e.toString());
      return const Stream.empty();
    }
  }

  Future<bool> addTechnician(Technician technician, String password) async {
    try {
      final docRef = firestoreRepo.techniciansCollection.doc();
      final technicianMap = technician.copyWith(uid: docRef.id).toMap();
      technicianMap['uid'] = docRef.id;

      final createTechAccountArguments = TechAccount(
          uid: docRef.id,
          serviceProviderId: technician.serviceProviderId,
          name: technician.name,
          email: technician.email,
          password: password);

      final response = await CloudFunctionsServices.call(
          functionName: 'createTechAccount', arguments: createTechAccountArguments.toMap());
      if (response?.success ?? false) {
        await docRef.set(technicianMap);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      e.logException();
      return false;
    }
  }

  Future<bool> updateTechnician(Technician technician) async {
    try {
      final technicianMap = technician.toMap();
      final docRef = firestoreRepo.techniciansCollection.doc(technician.uid);
      await docRef.update(technicianMap);
      return true;
    } catch (e) {
      e.logException();
      return false;
    }
  }

  Future<bool> deleteTechnician(Technician technician) async {
    try {
      final technicianMap = technician.copyWith(isDeleted: true).toMap();
      final docRef = firestoreRepo.techniciansCollection.doc(technician.uid);
      await docRef.update(technicianMap);
      return true;
    } catch (e) {
      e.logException();
      return false;
    }
  }

  Future<Technician?> getTechnicianFromUid(String technicianId) async {
    try {
      final technicianData = (await firestoreRepo.techniciansCollection.doc(technicianId).get()).data();
      if (technicianData != null) {
        final technician = Technician.fromMap(technicianData);
        return technician;
      } else {
        return null;
      }
    } catch (e) {
      e.logException();
      return null;
    }
  }

  Stream<Technician> getTechnicianStream(String technicianId) {
    try {
      final technicianStream = firestoreRepo.techniciansCollection
          .doc(technicianId)
          .snapshots()
          .map((doc) => Technician.fromMap(doc.data()!));
      return technicianStream;
    } catch (e) {
      e.logException();
      return const Stream.empty();
    }
  }

  Future<bool> updateTechnicianLiveLocation(TechLiveLocation location) async {
    try {
      final docRef = firestoreRepo.technicianLiveLocationsCollection.doc();
      final locationMap = location.copyWith(id: docRef.id).toMap();
      await docRef.set(locationMap);
      return true;
    } catch (e) {
      e.logException();
      return false;
    }
  }
}
