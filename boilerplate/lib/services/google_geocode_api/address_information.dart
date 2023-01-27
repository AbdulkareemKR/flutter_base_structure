import 'package:collection/collection.dart';

class AddressInformation {
  String? street;
  String? neighborhood;
  String? city;
  String? province;
  String? country;

  AddressInformation({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.province,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'neighborhood': neighborhood,
      'city': city,
      'province': province,
      'country': country,
    };
  }

  factory AddressInformation.fromMap(Map<String, dynamic> map) {
    List locationInfo = map['results'][0]["address_components"];

    return AddressInformation(
      street: locationInfo
          .firstWhereOrNull((addressComponent) => (addressComponent["types"] as List).contains("route"))?["long_name"],
      neighborhood: locationInfo.firstWhereOrNull(
          (addressComponent) => (addressComponent["types"] as List).contains("sublocality"))?["long_name"],
      city: locationInfo.firstWhereOrNull(
          (addressComponent) => (addressComponent["types"] as List).contains("locality"))?["long_name"],
      province: locationInfo.firstWhereOrNull((addressComponent) =>
          (addressComponent["types"] as List).contains("administrative_area_level_1"))?["long_name"],
      country: locationInfo.firstWhereOrNull(
          (addressComponent) => (addressComponent["types"] as List).contains("country"))?["long_name"],
    );
  }

  @override
  String toString() {
    return 'GoogleGeocoding(street: $street, neighborhood: $neighborhood, city: $city, province: $province, country: $country)';
  }
}
