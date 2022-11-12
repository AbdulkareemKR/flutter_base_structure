import '../models/user_location.dart';

String getCityNameFromLocation(UserLocation? location) {
  /// TODO: This should return the city name from our constant collection [City] based on the user location
  /// Something like this (NOTE that this is only a pseudoscope):
  /// ```
  /// ` final  cityId = location.cityId;
  /// `citiesProvider.getCityFromId(cityId: cityId);
  /// ```
  ///
  if (location == null) {
    // TODO : use local
    return "لم يتم اضافة موقع";
  }
  // For testing I will return 'ظهران'
  return getCityNameFromLatLng(location.latitude, location.longitude);
}

String getCityNameFromLatLng(double lat, double lng) {
  // TODO : local

  return 'الظهران';
}
