import 'dart:convert';

/// A representation of all the api keys used across all the platforms.
class ApiKeysEnvironmentVariables {
  final String googleMaps;
  final String amplitude;
  final String sentryKey;
  ApiKeysEnvironmentVariables({
    required this.googleMaps,
    required this.amplitude,
    required this.sentryKey,
  });

  ApiKeysEnvironmentVariables copyWith({
    String? googleMaps,
    String? amplitude,
    String? sentryKey,
  }) {
    return ApiKeysEnvironmentVariables(
      googleMaps: googleMaps ?? this.googleMaps,
      amplitude: amplitude ?? this.amplitude,
      sentryKey: sentryKey ?? this.sentryKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'googleMaps': googleMaps,
      'amplitude': amplitude,
      'sentryKey': sentryKey,
    };
  }

  factory ApiKeysEnvironmentVariables.fromMap(Map<String, dynamic> map) {
    return ApiKeysEnvironmentVariables(
      googleMaps: map['googleMaps'] ?? '',
      amplitude: map['amplitude'] ?? '',
      sentryKey: map['sentryKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiKeysEnvironmentVariables.fromJson(String source) =>
      ApiKeysEnvironmentVariables.fromMap(json.decode(source));

  @override
  String toString() => 'ApiKeysEnvironmentVariables(googleMaps: $googleMaps, amplitude: $amplitude, sentryKey: $sentryKey)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApiKeysEnvironmentVariables &&
      other.googleMaps == googleMaps &&
      other.amplitude == amplitude &&
      other.sentryKey == sentryKey;
  }

  @override
  int get hashCode => googleMaps.hashCode ^ amplitude.hashCode ^ sentryKey.hashCode;
}
