import 'package:garage_core/services/google_geocode_api/address_information.dart';
import 'package:garage_core/services/google_geocode_api/google_geocode.dart';
import 'dart:convert';
import 'package:garage_core/utilis/logger/g_logger.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

class GoogleGeocodeServices {
  static AddressInformation getAddressFromGoogleGeocode(GoogleGeocodeResult googleGeocode) {
    final addressInformation = AddressInformation(
      street: googleGeocode.results?.first.addressComponents
          ?.firstWhereOrNull((addressComponent) => addressComponent.types?.contains("route") ?? false)
          ?.longName,
      neighborhood: googleGeocode.results?.first.addressComponents
          ?.firstWhereOrNull((addressComponent) => addressComponent.types?.contains("sublocality") ?? false)
          ?.longName,
      city: googleGeocode.results?.first.addressComponents
          ?.firstWhereOrNull((addressComponent) => addressComponent.types?.contains("locality") ?? false)
          ?.longName,
      province: googleGeocode.results?.first.addressComponents
          ?.firstWhereOrNull(
              (addressComponent) => addressComponent.types?.contains("administrative_area_level_1") ?? false)
          ?.longName,
      country: googleGeocode.results?.first.addressComponents
          ?.firstWhereOrNull((addressComponent) => addressComponent.types?.contains("country") ?? false)
          ?.longName,
    );

    return addressInformation;
  }

  static Future<AddressInformation?> findLocationInformation(
      double latitude, double longitude, String googleApiKey, String? language) async {
    final params = {
      "latlng": "$latitude,$longitude",
      "key": googleApiKey,
      "language": language ?? "ar",
    };

    try {
      Uri uri = Uri.https("maps.googleapis.com", "maps/api/geocode/json", params);

      final response = await http.get(uri);
      final parsedJson = json.decode(response.body);

      final googleGeocode = GoogleGeocodeResult.fromMap(parsedJson);
      return getAddressFromGoogleGeocode(googleGeocode);
    } catch (e) {
      GLogger.error(e.toString());
      return null;
    }
  }
}
