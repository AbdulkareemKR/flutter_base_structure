import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/global_services/services/google_direction_services/direction_api.dart';
import 'package:garage_client/global_services/services/location_services.dart';
import 'package:garage_client/app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/google_direction_services/polyline_result.dart';
import 'package:garage_client/environments/environments.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final serviceProviderMarkerProvider = FutureProvider<BitmapDescriptor>((ref) {
  final serviceProviderMarker = BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(80.w, 80.w)),
    AssetsConst.directionArrowPng,
  ).then(
    (icon) {
      return icon;
    },
  );
  return serviceProviderMarker;
});

final customerMarkerProvider = FutureProvider<BitmapDescriptor>((ref) {
  final customerMarker = BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(100.w, 100.w)),
    AssetsConst.locationPointPng,
  ).then(
    (icon) {
      return icon;
    },
  );
  return customerMarker;
});
final techLiveLocationStream = StreamProvider.autoDispose.family<TechLiveLocation?, Order>(
  (ref, order) {
    return getTechLiveLocation(order.id ?? "");
  },
);

final techLiveLocationProvider = StateProvider.autoDispose.family<TechLiveLocation?, Order>((ref, order) {
  return ref
      .watch(techLiveLocationStream(order))
      .when(data: (value) => value, error: (error, stackTrace) => null, loading: () => null);
});

final directionAsyncProvider = FutureProvider.autoDispose.family<PolylineResult?, Order>(
  (ref, order) {
    return ref.watch(techLiveLocationProvider(order)) != null
        ? DirectionApi(
            origin: LatLng(ref.watch(techLiveLocationProvider(order))!.location.latitude,
                ref.watch(techLiveLocationProvider(order))!.location.longitude),
            destination: LatLng(order.location.latitude, order.location.longitude),
            googleApiKey: Environment.instance.apiKeys!.googleMaps,
            language: App.lang,
          ).getRouteBetweenCoordinates()
        : null;
  },
);

final directionProvider = StateProvider.autoDispose.family<PolylineResult?, Order>(
  (ref, order) {
    return ref
        .watch(directionAsyncProvider(order))
        .when(data: (value) => value, error: (error, stackTrace) => null, loading: () => null);
  },
);
