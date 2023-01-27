import 'dart:convert';

import 'package:garage_client/environments/enums/environment_type.dart';
import 'package:garage_client/services/enum_services.dart';

export 'package:garage_client/services/enum_services.dart';

class Environment {
  final EnvironmentType type;
  Environment({
    required this.type,
  });

  /// Check if the current environment is `Development`
  bool get isDev => type == EnvironmentType.development;

  Environment copyWith({
    EnvironmentType? type,
  }) {
    return Environment(
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': enumToString(type),
    };
  }

  factory Environment.fromMap(Map<String, dynamic> map) {
    return Environment(type: enumFromString(EnvironmentType.values, map['type']));
  }

  String toJson() => json.encode(toMap());

  factory Environment.fromJson(String source) => Environment.fromMap(json.decode(source));

  @override
  String toString() => 'Environment(type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Environment && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;
}
