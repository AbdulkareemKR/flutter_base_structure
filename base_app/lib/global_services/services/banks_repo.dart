import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/bank.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';

final banksRepoProvider = Provider<BanksRepo>(
  (ref) => BanksRepo(firestoreRepo: ref.watch(firestoreRepoProvider)),
);

class BanksRepo {
  BanksRepo({required this.firestoreRepo});
  final FirestoreRepo firestoreRepo;

  Future<List<Bank?>> getAllBanks() async {
    try {
      final banksData = (await firestoreRepo.banksCollection.get());
      if (banksData.docs.isNotEmpty) {
        log(banksData.docs.toString());
        final banks = banksData.docs.map((bank) => Bank.fromMap(bank.data())).toList();
        return banks;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
