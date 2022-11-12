import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/environments/environments.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/loaction/domain/enums/location_view_mode.dart';
import 'package:garage_client/features/loaction/domain/models/location_state.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/widgets/animated_dialog.dart';
import 'package:garage_core/models/car_owner.dart';
import 'package:garage_core/models/order.dart';
import 'package:garage_core/services/car_owner_repo.dart';
import 'package:garage_core/services/cloud_functions_services.dart';
import 'package:garage_core/services/location_services.dart';
import 'package:garage_core/services/random_generator.dart';
import 'package:garage_core/services/validator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:garage_core/services/google_geocode_api/address_information.dart';
import 'package:garage_core/services/google_geocode_api/google_geocode_services.dart';

final locationStateProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier(LocationState(isBeingEditedLocation: false, viewMode: LocationViewMode.view), ref: ref);
});

final locationGeocodingStateProvider = StateProvider.autoDispose<AddressInformation?>((ref) => null);

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier(state, {required this.ref}) : super(state);

  late GoogleMapController mapController;
  final noteController = TextEditingController();
  final Ref ref;

  void changeDefaultLocation(UserLocation location, String uid) async {
    ref.read(carOwnerRepoProvider).changeUserDefaultLocation(location, uid);
    updateCameraPosition();
  }

  void updateCameraPosition() {
    ref.listen<AsyncValue<CarOwner?>>(carOwnerProvider, (previous, next) {
      next.whenData((value) {
        if (value != null && value.defaultLocation != null) {}
        _changeCameraPosition(value!.defaultLocation!.latitude, value.defaultLocation!.longitude);
      });
    });
  }

  void updateCurrentLocation() async {
    final currentLatLng = await markerLatLong;
    final locationGeocoding = await GoogleGeocodeServices.findLocationInformation(
        currentLatLng.latitude, currentLatLng.longitude, Environment.instance.apiKeys!.googleMaps, App.lang);
    ref.read(locationGeocodingStateProvider.notifier).state = locationGeocoding;
  }

  Future<void> onAddNewLocation(BuildContext context) async {
    state = state.copyWith(viewMode: LocationViewMode.add, isBeingEditedLocation: true);
    updateCurrentLocation();
  }

  void _changeCameraPosition(double lat, double lng) {
    mapController.animateCamera((CameraUpdate.newLatLng(LatLng(lat, lng))));
  }

  void changeBeingEditedLocation(UserLocation location) {
    noteController.text = location.note ?? '';
    _changeCameraPosition(location.latitude, location.longitude);
    state = state.copyWith(isBeingEditedLocation: true, viewMode: LocationViewMode.edit, editedLocationId: location.id);
    updateCurrentLocation();
  }

  Future<void> onLocationSavePress({required String uid, required BuildContext context}) async {
    final latLng = await markerLatLong;

    if (!Validator.safeIsNotEmpty(noteController.text)) {
      await GarageDialog.show(
          context: context,
          style: DialogStyle.error,
          message: 'emptyFieldMessage'.translate(arguments: ['orders.location'.translate()]));
    } else {
      final locationGeocoding = await GoogleGeocodeServices.findLocationInformation(
          latLng.latitude, latLng.longitude, Environment.instance.apiKeys!.googleMaps, "en");

      final getCityIdByNameArguments = {"cityNameEn": locationGeocoding?.city};
      final getCityIdByName =
          await CloudFunctionsServices.call(functionName: 'getCityIdByName', arguments: getCityIdByNameArguments);

      if (getCityIdByName?.data == null) {
        await GarageDialog.show(
            context: context, style: DialogStyle.error, message: "location.unknownLocation".translate());
      } else {
        final location = UserLocation(
          latitude: latLng.latitude,
          longitude: latLng.longitude,
          note: noteController.text,
          id: state.editedLocationId ?? generateRandomString(8),
          cityId: getCityIdByName!.data,
          title: noteController.text,
        );

        switch (state.viewMode) {
          case LocationViewMode.add:
            await addLocationForUid(uid, location);
            break;

          case LocationViewMode.edit:
            await editLocationForUid(uid, location);
            break;
          default:
            break;
        }

        state = state.copyWith(isBeingEditedLocation: false, editedLocationId: null, viewMode: LocationViewMode.view);
        noteController.text = '';
        updateCameraPosition();

        await GarageDialog.show(
            context: context, style: DialogStyle.success, message: "location.locationHasBeenSaved".translate());
      }
    }
  }

  Future<void> onDeletePressed(UserLocation location, String uid) async {
    await deleteLocationForUid(uid, location);
  }

  bool get canDragMap => state.isBeingEditedLocation == true;

  /// Multiply with 0.5 times the padding for the map
  ///
  /// to get the actual marker position
  Future<LatLng> get markerLatLong => mapController.getLatLng(ScreenCoordinate(
      x: 0.5.sw.toInt() + (0.5 * SpacingConst.mapPadding.left).toInt(),
      y: 0.5.sh.toInt() - (0.5 * SpacingConst.mapPadding.bottom).toInt()));
}
