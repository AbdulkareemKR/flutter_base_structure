import 'package:garage_client/global_services/services/google_geocode_api/address_component.dart';

class Result {
  List<AddressComponent>? addressComponents;

  Result({
    required this.addressComponents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressComponents': addressComponents?.map((addressComponent) => addressComponent.toMap()).toList(),
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      addressComponents: map['address_components'] != null
          ? List.from((map['address_components']))
              .map((addressComponents) => AddressComponent.fromMap(addressComponents))
              .toList()
          : null,
    );
  }
}
