import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_core/models/car_owner.dart';
import 'package:garage_core/models/order.dart';
import 'package:garage_core/services/car_owner_services.dart';
import 'package:garage_core/services/firestore_services.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<bool> addLocationForUid(String uid, UserLocation location) async {
  try {
    final carOwnerData = (await FirestoreServices.carOwnersCollection.doc(uid).get()).data();
    if (carOwnerData != null) {
      final carOwner = CarOwner.fromMap(carOwnerData);
      if (!carOwner.locations.contains(location)) {
        if (carOwner.locations.isEmpty) {
          await FirestoreServices.carOwnersCollection.doc(uid).update({
            'locations': FieldValue.arrayUnion([location.toMap()]),
            'defaultLocation': location.toMap()
          });
        } else {
          await FirestoreServices.carOwnersCollection.doc(uid).update({
            'locations': FieldValue.arrayUnion([location.toMap()]),
          });
        }

        return true;
      } else {
        GLogger.debug('The location already exists');
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    e.logException();
    return false;
  }
}

Future<bool> deleteLocationForUid(String uid, UserLocation location) async {
  try {
    final carOwner = await getCarOwnerFromId(uid);
    if (carOwner is CarOwner) {
      if (carOwner.locations.contains(location)) {
        final newLocations = carOwner.locations.toList();
        newLocations.remove(location);
        final newLocationsMap = [];
        for (var location in newLocations) {
          newLocationsMap.add(location.toMap());
        }
        if (carOwner.defaultLocation == location) {
          await FirestoreServices.carOwnersCollection.doc(uid).update({
            'locations': newLocationsMap,
            'defaultLocation': newLocationsMap.isNotEmpty ? newLocationsMap.first : FieldValue.delete()
          });
        } else {
          await FirestoreServices.carOwnersCollection.doc(uid).update({'locations': newLocationsMap});
        }
        return true;
      } else {
        GLogger.warning('The user dose not have this location');
        return false;
      }
    }
    return false;
  } catch (e) {
    e.logException();
    return false;
  }
}

Future<bool> editLocationForUid(String uid, UserLocation location) async {
  try {
    final carOwner = await getCarOwnerFromId(uid);
    if (carOwner is CarOwner) {
      UserLocation? locationToEdit;
      try {
        locationToEdit = carOwner.locations.firstWhere((locationElement) => location.id == locationElement.id);
      } catch (e) {
        e.logException();
      }
      if (locationToEdit != null) {
        final newLocations = carOwner.locations.toList();
        newLocations.removeWhere((location) => location.id == locationToEdit!.id);
        newLocations.add(location);
        final newLocationsMap = [];
        for (var locationElement in newLocations) {
          newLocationsMap.add(locationElement.toMap());
        }
        if (carOwner.defaultLocation?.id == locationToEdit.id) {
          await FirestoreServices.carOwnersCollection
              .doc(uid)
              .update({'locations': newLocationsMap, 'defaultLocation': location.toMap()});
        } else {
          await FirestoreServices.carOwnersCollection.doc(uid).update({'locations': newLocationsMap});
        }
        return true;
      }
      return false;
    }
    return false;
  } catch (e) {
    e.logException();
    return false;
  }
}

Stream<TechLiveLocation?> getTechLiveLocation(String orderId) {
  try {
    final snapshot = FirestoreServices.techLiveLocationCollection
        .where("orderId", isEqualTo: orderId)
        .limit(1)
        .snapshots()
        .map((list) {
      final techLiveLocationList = list.docs.map((doc) => TechLiveLocation.fromMap(doc.data())).toList();
      if (techLiveLocationList.isNotEmpty) {
        return techLiveLocationList.first;
      }
    });
    return snapshot;
  } catch (e) {
    e.logException();
    return const Stream.empty();
  }
}
