import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/car_owner.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';

final carOwnerRepoProvider = Provider<CarOwnerRepo>(
  (ref) => CarOwnerRepo(ref.watch(firestoreRepoProvider)),
);

class CarOwnerRepo {
  CarOwnerRepo(this.firestoreRepo);
  final FirestoreRepo firestoreRepo;

  Future<CarOwner?> getCarOwnerFromId(String uid) async {
    final user = await firestoreRepo.carOwnersCollection.where('uid', isEqualTo: uid).get();
    if (user.docs.isNotEmpty) {
      final carOwner = CarOwner.fromMap(user.docs.first.data());
      return carOwner;
    } else {
      return null;
    }
  }

  Stream<CarOwner> getCarOwnerStream(String uid, {bool ignoreDefaultCar = false}) {
    try {
      final user = firestoreRepo.carOwnersCollection.doc(uid).snapshots().map((doc) {
        try {
          final carOwner = CarOwner.fromMap(doc.data()!);

          if (ignoreDefaultCar) {
            carOwner.defaultCar = null;
          }

          return carOwner;
        } catch (e) {
          // Ensure that the user is logged out when any error is encountered

          log("Logging out the current user with $uid because of an error in their data");
          FirebaseAuth.instance.signOut().ignore();

          log('$e');
          ;
          throw Exception(e);
        }
      });
      return user;
    } catch (e) {
      log('$e');
      ;
      throw Exception(e);
    }
  }

  Future<CarOwner?> createCarOwner(String uid, String name, String phoneNumber) async {
    final CarOwner carOwner = CarOwner(uid: uid, name: name, phoneNumber: phoneNumber);
    try {
      await firestoreRepo.carOwnersCollection.doc(uid).set(carOwner.toMap(), SetOptions(merge: true));
      return carOwner;
    } catch (e) {
      log('$e');
      ;
      return null;
    }
  }

  Future<bool> changeUserDefaultLocation(UserLocation location, String uid) async {
    try {
      await firestoreRepo.carOwnersCollection.doc(uid).update({'defaultLocation': location.toMap()});
      return true;
    } catch (e) {
      log('$e');
      ;
      return false;
    }
  }

  Future<bool> changeUserName(String uid, String name) async {
    try {
      await firestoreRepo.carOwnersCollection.doc(uid).update({'name': name});
      return true;
    } catch (e) {
      log('$e');
      ;
      return false;
    }
  }
}
