import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/services/firestore_repo.dart';
import 'package:garage_client/models/neighborhood.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:collection/collection.dart';

final neighborhoodRepoProvider = Provider<NeighborhoodRepo>((ref) {
  return NeighborhoodRepo(ref.watch(firestoreRepoProvider));
});

final neighborhoodsByCityIdProvider = FutureProvider.family<List<Neighborhood?>, String?>((ref, cityId) async {
  return ref.watch(neighborhoodRepoProvider).getNeighborhoodsByCityId(cityId);
});

final nearestNeighborhoodProvider = FutureProvider.family<Neighborhood?, LatLng>((ref, latLng) async {
  /// [attemptsLimit] is the number of attempts for getting the nearest neighborhood, each attempt will have more errorRange to increase the borders of the neighborhoods, if there is no near neighborhood, null will be returned\

  const attemptsLimit = 3;
  double errorRange = 0;

  Neighborhood? userNeighborhood;

  for (int attemptNumber = 0; attemptNumber < attemptsLimit; attemptNumber++) {
    final neighborhoods = await ref
        .watch(neighborhoodRepoProvider)
        .getNeighborhoodFromLatLngBorders(latLng: latLng, errorRange: errorRange);

    /// get the neighborhood of the user's location by checking that if it is within
    /// the borders of the North-East and South-West coordinates of each neighborhood
    userNeighborhood = neighborhoods.firstWhereOrNull(
      (neighborhood) =>
          (neighborhood.neCoordinates.latitude + errorRange) >= latLng.latitude &&
          (neighborhood.neCoordinates.longitude + errorRange) >= latLng.longitude &&
          (neighborhood.swCoordinates.latitude - errorRange) <= latLng.latitude &&
          (neighborhood.swCoordinates.longitude - errorRange) <= latLng.longitude,
    );

    if (userNeighborhood != null) {
      break;
    }

    errorRange += 0.005;
  }

  return userNeighborhood;
});

class NeighborhoodRepo {
  final FirestoreRepo firestoreRepo;

  NeighborhoodRepo(this.firestoreRepo);

  Future<List<Neighborhood>> getNeighborhoodsByCityId(String? cityId) async {
    try {
      final neighborhoodData =
          (await firestoreRepo.neighborhoodsCollection.where("cityId", isEqualTo: cityId).get()).docs;
      if (neighborhoodData.isNotEmpty) {
        final neighborhoodList =
            neighborhoodData.map<Neighborhood>((order) => Neighborhood.fromMap(order.data())).toList();
        return neighborhoodList;
      } else {
        return [];
      }
    } catch (e) {
      e.logException();
      return [];
    }
  }

  Future<List<Neighborhood>> getNeighborhoodFromLatLngBorders({required LatLng latLng, double errorRange = 0}) async {
    try {
      /// find the neighborhoods that has the north east point greater than the location point of the user. This way will get all potential neighborhoods that the user might be in
      ///
      /// errorRange is used to add relaxation of the neighborhoods margins in case no neighborhood covers user location
      ///
      /// only one condition is used here because firebase does not allow multiple equality operations for different fields

      final neighborhoodData = (await firestoreRepo.neighborhoodsCollection
              .where("neCoordinates.longitude", isGreaterThanOrEqualTo: (latLng.longitude - errorRange))
              .get())
          .docs;

      if (neighborhoodData.isNotEmpty) {
        final neighborhoodList =
            neighborhoodData.map<Neighborhood>((order) => Neighborhood.fromMap(order.data())).toList();
        return neighborhoodList;
      } else {
        return [];
      }
    } catch (e) {
      e.logException();
      return [];
    }
  }
}
