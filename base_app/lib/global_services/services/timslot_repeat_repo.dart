import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/timeslot_repeat.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';

final timeslotRepeatRepoProvider = Provider<TimeslotRepeatRepo>((ref) {
  return TimeslotRepeatRepo(firestoreRepo: ref.watch(firestoreRepoProvider));
});

class TimeslotRepeatRepo {
  final FirestoreRepo firestoreRepo;
  TimeslotRepeatRepo({
    required this.firestoreRepo,
  });

  Future<bool> addListTimeslotsRepeat(List<TimeslotRepeat> timslotRepeatsList) async {
    try {
      for (final timeslotRepeat in timslotRepeatsList) {
        await addTimeslotRepeat(timeslotRepeat);
      }
      return true;
    } catch (e) {
      log('$e');
      ;
      return false;
    }
  }

  Future<bool> addTimeslotRepeat(TimeslotRepeat timeslotRepeat) async {
    try {
      final docRef = firestoreRepo.timeslotRepeatsCollection.doc();
      final timeslotCopy = timeslotRepeat.copyWith(id: docRef.id);
      await docRef.set(timeslotCopy.toMap());
      return true;
    } catch (e) {
      log('$e');
      ;
      return false;
    }
  }

  Future<bool> updateTimeslotRepeat(TimeslotRepeat timeslotRepeat) async {
    try {
      await firestoreRepo.timeslotRepeatsCollection.doc(timeslotRepeat.id).update(timeslotRepeat.toUpdateMap());

      return true;
    } catch (e) {
      log('$e');
      ;
      return false;
    }
  }

  Future<bool> deleteTimeslot(TimeslotRepeat timeslotRepeat) async {
    try {
      await firestoreRepo.timeslotRepeatsCollection.doc(timeslotRepeat.id).delete();

      return true;
    } catch (e) {
      log('$e');
      ;
      return false;
    }
  }
}
