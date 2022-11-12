import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

/// A representation of all firebase configurations
class FirebaseEnvironmentVariables {
  final String apiKeyIOS;
  final String appIdIOS;
  final String apiKeyAndroid;
  final String appIdAndroid;
  final String apiKeyWeb;
  final String appIdWeb;
  final String messagingSenderId;
  final String projectId;
  final String authDomain;
  final String storageBucket;
  final String measurementId;
  final String iosClientId;
  final String iosBundleId;
  FirebaseEnvironmentVariables({
    required this.apiKeyIOS,
    required this.appIdIOS,
    required this.apiKeyAndroid,
    required this.appIdAndroid,
    required this.apiKeyWeb,
    required this.appIdWeb,
    required this.messagingSenderId,
    required this.projectId,
    required this.authDomain,
    required this.storageBucket,
    required this.measurementId,
    required this.iosClientId,
    required this.iosBundleId,
  });

  FirebaseEnvironmentVariables copyWith({
    String? apiKeyIOS,
    String? appIdIOS,
    String? apiKeyAndroid,
    String? appIdAndroid,
    String? apiKeyWeb,
    String? appIdWeb,
    String? messagingSenderId,
    String? projectId,
    String? authDomain,
    String? storageBucket,
    String? measurementId,
    String? iosClientId,
    String? iosBundleId,
  }) {
    return FirebaseEnvironmentVariables(
      apiKeyIOS: apiKeyIOS ?? this.apiKeyIOS,
      appIdIOS: appIdIOS ?? this.appIdIOS,
      apiKeyAndroid: apiKeyAndroid ?? this.apiKeyAndroid,
      appIdAndroid: appIdAndroid ?? this.appIdAndroid,
      apiKeyWeb: apiKeyWeb ?? this.apiKeyWeb,
      appIdWeb: appIdWeb ?? this.appIdWeb,
      messagingSenderId: messagingSenderId ?? this.messagingSenderId,
      projectId: projectId ?? this.projectId,
      authDomain: authDomain ?? this.authDomain,
      storageBucket: storageBucket ?? this.storageBucket,
      measurementId: measurementId ?? this.measurementId,
      iosClientId: iosClientId ?? this.iosClientId,
      iosBundleId: iosBundleId ?? this.iosBundleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'apiKeyIOS': apiKeyIOS,
      'appIdIOS': appIdIOS,
      'apiKeyAndroid': apiKeyAndroid,
      'appIdAndroid': appIdAndroid,
      'apiKeyWeb': apiKeyWeb,
      'appIdWeb': appIdWeb,
      'messagingSenderId': messagingSenderId,
      'projectId': projectId,
      'authDomain': authDomain,
      'storageBucket': storageBucket,
      'measurementId': measurementId,
      'iosClientId': iosClientId,
      'iosBundleId': iosBundleId,
    };
  }

  //TODO: Fix the issue with web, MacOS and Windows
  FirebaseOptions get firebaseOptions {
    late String _apiKey;
    late String _appId;

    if (kIsWeb) {
      _apiKey = apiKeyWeb;
      _appId = appIdWeb;
    } else if (Platform.isIOS || Platform.isMacOS) {
      _apiKey = apiKeyIOS;
      _appId = appIdIOS;
    } else if (Platform.isAndroid || Platform.isWindows || Platform.isLinux) {
      _apiKey = appIdAndroid;
      _appId = appIdAndroid;
    } else {
      log("Couldn't find platform api, going set android api");
      _apiKey = appIdAndroid;
      _appId = appIdAndroid;
    }

    return FirebaseOptions.fromPigeon(PigeonFirebaseOptions.decode({
      'apiKey': _apiKey,
      'appId': _appId,
      ...toMap(),
    }));
  }

  factory FirebaseEnvironmentVariables.fromMap(Map<String, dynamic> map) {
    return FirebaseEnvironmentVariables(
      apiKeyIOS: map['apiKeyIOS'] ?? '',
      appIdIOS: map['appIdIOS'] ?? '',
      apiKeyAndroid: map['apiKeyAndroid'] ?? '',
      appIdAndroid: map['appIdAndroid'] ?? '',
      apiKeyWeb: map['apiKeyWeb'] ?? '',
      appIdWeb: map['appIdWeb'] ?? '',
      messagingSenderId: map['messagingSenderId'] ?? '',
      projectId: map['projectId'] ?? '',
      authDomain: map['authDomain'] ?? '',
      storageBucket: map['storageBucket'] ?? '',
      measurementId: map['measurementId'] ?? '',
      iosClientId: map['iosClientId'] ?? '',
      iosBundleId: map['iosBundleId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseEnvironmentVariables.fromJson(String source) =>
      FirebaseEnvironmentVariables.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FirebaseEnvironmentVariables(apiKeyIOS: $apiKeyIOS, appIdIOS: $appIdIOS, apiKeyAndroid: $apiKeyAndroid, appIdAndroid: $appIdAndroid, apiKeyWeb: $apiKeyWeb, appIdWeb: $appIdWeb, messagingSenderId: $messagingSenderId, projectId: $projectId, authDomain: $authDomain, storageBucket: $storageBucket, measurementId: $measurementId, iosClientId: $iosClientId, iosBundleId: $iosBundleId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirebaseEnvironmentVariables &&
        other.apiKeyIOS == apiKeyIOS &&
        other.appIdIOS == appIdIOS &&
        other.apiKeyAndroid == apiKeyAndroid &&
        other.appIdAndroid == appIdAndroid &&
        other.apiKeyWeb == apiKeyWeb &&
        other.appIdWeb == appIdWeb &&
        other.messagingSenderId == messagingSenderId &&
        other.projectId == projectId &&
        other.authDomain == authDomain &&
        other.storageBucket == storageBucket &&
        other.measurementId == measurementId &&
        other.iosClientId == iosClientId &&
        other.iosBundleId == iosBundleId;
  }

  @override
  int get hashCode {
    return apiKeyIOS.hashCode ^
        appIdIOS.hashCode ^
        apiKeyAndroid.hashCode ^
        appIdAndroid.hashCode ^
        apiKeyWeb.hashCode ^
        appIdWeb.hashCode ^
        messagingSenderId.hashCode ^
        projectId.hashCode ^
        authDomain.hashCode ^
        storageBucket.hashCode ^
        measurementId.hashCode ^
        iosClientId.hashCode ^
        iosBundleId.hashCode;
  }
}
