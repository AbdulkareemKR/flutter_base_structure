import 'dart:developer';

import 'package:garage_client/global_services/models/order.dart';

import 'package:url_launcher/url_launcher.dart';

class GoogleMapServices {
  static Future<void> launchGoogleMap(UserLocation orderLocation) async {
    final userLocation = {"api": "1", "query": "${orderLocation.latitude},${orderLocation.longitude}"};
    try {
      final googleMapLaunchUri = Uri.https("www.google.com", "maps/search/", userLocation);

      if (await canLaunchUrl(googleMapLaunchUri)) {
        await launchUrl(googleMapLaunchUri);
      }
    } catch (e) {
      log('$e');
      ;
    }
  }
}
