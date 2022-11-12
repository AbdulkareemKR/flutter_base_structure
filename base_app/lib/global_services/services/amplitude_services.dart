import 'dart:developer';
import 'dart:io';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:garage_client/global_services/enums/amplitude_status.dart';

class AmplitudeServices {
  //This is the default, it will be change when we init the services.
  static AmplitudeStatus status = AmplitudeStatus.notInitialized;
  static late String _apiKey;

  /// This method used to init Amplitude services
  static Future<void> init(String apiKey) async {
    if (Platform.isWindows) {
      log('Amplitude is not supported on windows');
      return;
    }
    AmplitudeServices._apiKey = apiKey;
    if (apiKey.isEmpty) {
      //This indicates that there is no api key passed
      status = AmplitudeStatus.error;
      log('(Amplitude/init) No API key passed ⚠️');
    } else {
      await Amplitude.getInstance().init(apiKey);
      await setUserId('testUser');
      log("Amplitude status: initialized ✅");

      // The services are initialized successfully
      status = AmplitudeStatus.initialized;
    }
  }

  /// This method used to log events to Amplitude, you need to pass the event type and a [Map<String, dynamic>] containing the event props.
  static void logEvent(String eventType, Map<String, dynamic> eventProperties) async {
    if (status == AmplitudeStatus.error) {
      // In case of an error in the init.
      // This should be changed from print statement to logger.
      log('(Amplitude/logEvent) No API key passed when initializing Amplitude 🔴');
    } else {
      await ensureInitialized();
      await Amplitude.getInstance().logEvent(eventType, eventProperties: eventProperties);
    }
  }

  /// This method used to set the user id that will be associated with the events on Amplitude
  static Future<void> setUserId(String userId) async {
    // TODO(Nawaf):  change it so it gets the uid from FirebaseAuth later.
    await Amplitude.getInstance().setUserId(userId);
  }

  static Future<void> ensureInitialized() async {
    if (status == AmplitudeStatus.notInitialized) {
      await init(AmplitudeServices._apiKey);
    }
  }
}
