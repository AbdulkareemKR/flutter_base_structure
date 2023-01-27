import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/environments/services/environment_services.dart';
import 'package:garage_client/models/translatable.dart';
import 'package:garage_client/services/cities_repo.dart';
import 'package:garage_client/services/google_geocode_api/address_information.dart';
import 'package:garage_client/services/google_geocode_api/google_geocode_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final cityNameProvider = FutureProvider.family<Translatable, String>((ref, cityId) async {
  return ref.read(citiesRepoProvider).getCityName(cityId);
});

final locationGeocodingProvider = FutureProvider.family.autoDispose<AddressInformation?, LatLng>((ref, latLng) async =>
    await GoogleGeocodeServices.findLocationInformation(
        latLng.latitude, latLng.longitude, Environment.instance.apiKeys!.googleMaps, App.lang));
