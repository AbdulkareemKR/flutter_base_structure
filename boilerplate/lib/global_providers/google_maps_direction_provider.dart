import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/environments/services/environment_services.dart';
import 'package:garage_client/models/google_maps/gcompleter.dart';
import 'package:garage_client/services/google_map_direction_services/direction_api.dart';
import 'package:garage_client/services/location_services.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/services/order_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:garage_client/models/order.dart';
import 'package:garage_client/services/google_map_direction_services/polyline_result.dart';

final directionProvider = FutureProvider.autoDispose.family<PolylineResult?, String>((ref, orderId) async {
  final order = await ref.watch(streamedOrderProvider(orderId).future);
  return ref
      .watch(techLiveLocationStream(orderId))
      .whenData((techLiveLocation) => order != null && techLiveLocation != null
          ? DirectionApi(
              origin: LatLng(techLiveLocation.location.latitude, techLiveLocation.location.longitude),
              destination: LatLng(order.location.latitude, order.location.longitude),
              googleApiKey: Environment.instance.apiKeys!.googleMaps,
              language: App.lang,
            ).getRouteBetweenCoordinates()
          : null)
      .value;
});

// FIXME: use svg instead of png, you can utilize the function in garage_client/lib/services/google_map_services.dart
final serviceProviderMarkerProvider = FutureProvider<BitmapDescriptor>((ref) {
  final serviceProviderMarker = BitmapDescriptor.fromAssetImage(
    ImageConfiguration.empty,
    AssetsConst.manAvatarPng,
  ).then(
    (icon) {
      return icon;
    },
  );
  return serviceProviderMarker;
});

// FIXME: use svg instead of png, you can utilize the function in garage_client/lib/services/google_map_services.dart
final customerMarkerProvider = FutureProvider<BitmapDescriptor>((ref) {
  final customerMarker = BitmapDescriptor.fromAssetImage(
    ImageConfiguration.empty,
    AssetsConst.locationPointPng,
  ).then(
    (icon) {
      return icon;
    },
  );
  return customerMarker;
});

final techLiveLocationStream = StreamProvider.autoDispose.family<TechLiveLocation?, String>(
  (ref, orderId) {
    return getTechLiveLocation(orderId);
  },
);

final googleMapCompleterProvider = StateProvider<GCompleter<GoogleMapController>>((ref) {
  return GCompleter<GoogleMapController>();
});
