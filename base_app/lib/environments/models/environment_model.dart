import 'dart:convert';

import 'package:garage_core/environments/environments.dart';

import 'api_keys_environment_variables.dart';

/// A representation of all the environment variables defined in `.env` file
class EnvironmentModel extends Environment {
  EnvironmentModel({
    required EnvironmentType type,
    required this.firebase,
    required this.apiKeys,
  }) : super(type: type);

  final FirebaseEnvironmentVariables? firebase;
  final ApiKeysEnvironmentVariables? apiKeys;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'firebase': firebase?.toMap(),
      'apiKeys': apiKeys?.toMap(),
    };
  }

  factory EnvironmentModel.fromMap(Map<String, dynamic> map) {
    final baseEnvironment = Environment.fromMap(map);

    return EnvironmentModel(
      type: baseEnvironment.type,
      firebase: map['firebase'] != null ? FirebaseEnvironmentVariables.fromJson(map['firebase']) : null,
      apiKeys: map['apiKeys'] != null ? ApiKeysEnvironmentVariables.fromJson(map['apiKeys']) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory EnvironmentModel.fromJson(String source) => EnvironmentModel.fromMap(json.decode(source));

  @override
  String toString() => 'EnvironmentModel(firebase: $firebase, apiKeys: $apiKeys)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnvironmentModel && other.firebase == firebase && other.apiKeys == apiKeys;
  }

  @override
  int get hashCode => firebase.hashCode ^ apiKeys.hashCode;
}
