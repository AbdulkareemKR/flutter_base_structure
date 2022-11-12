import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/city.dart';
import 'package:garage_client/global_services/models/translatable.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';
import 'package:garage_client/global_services/services/validator.dart';

final citiesRepoProvider = Provider<CitiesRepo>((ref) {
  return CitiesRepo(ref.watch(firestoreRepoProvider));
});

class CitiesRepo {
  final FirestoreRepo firestoreRepo;

  CitiesRepo(this.firestoreRepo);

  Future<Translatable> getCityName(String cityId) async {
    try {
      if (!Validator.safeIsNotEmpty(cityId)) {
        throw Exception("City ID is empty");
      }
      final cityData = (await firestoreRepo.citiesCollection.doc(cityId).get()).data();
      if (cityData != null) {
        final city = City.fromMap(cityData);
        return city.name;
      } else {
        return Translatable(ar: 'غير معروف', en: 'Unknown');
      }
    } catch (e) {
      log('$e');
      return Translatable(ar: 'غير معروف', en: 'Unknown');
    }
  }

  Future<List<City?>> getAllCities() async {
    try {
      final cityData = (await firestoreRepo.citiesCollection.get());
      if (cityData.docs.isNotEmpty) {
        final cities = cityData.docs.map((city) => City.fromMap(city.data())).toList();
        return cities;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
