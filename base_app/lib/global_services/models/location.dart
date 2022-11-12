import 'dart:convert';

import 'package:garage_client/global_services/enums/direction.dart';
import 'package:garage_client/global_services/environments/models/environment.dart';
import 'package:garage_client/global_services/models/exportable.dart';

class Location extends Exportable {
  final String? id;
  final double latitude;
  final double longitude;
  final Direction? direction;
  Location({
    this.id,
    required this.latitude,
    required this.longitude,
    this.direction,
  });

  Location copyWith({
    String? id,
    double? latitude,
    double? longitude,
    Direction? direction,
  }) {
    return Location(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      direction: direction ?? this.direction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'direction': enumToString(direction),
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] != null ? map['id'] as String : null,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      direction: map['direction'] != null ? enumFromString(Direction.values, map['direction']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Location(id: $id, latitude: $latitude, longitude: $longitude, direction: $direction)';
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.id == id && other.latitude == latitude && other.longitude == longitude && other.direction == direction;
  }

  @override
  int get hashCode {
    return id.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ direction.hashCode;
  }
}
