import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_core/models/flutter_timestamp.dart';
import 'package:garage_core/models/location.dart';

class TechLiveLocation {
  String id;
  Timestamp time;
  Location location;
  String technitianId;
  String orderId;
  TechLiveLocation({
    required this.time,
    required this.location,
    required this.id,
    required this.technitianId,
    required this.orderId,
  });

  TechLiveLocation copyWith({
    String? id,
    String? technitianId,
    String? orderId,
    Timestamp? time,
    Location? location,
  }) {
    return TechLiveLocation(
      id: id ?? this.id,
      time: time ?? this.time,
      location: location ?? this.location,
      orderId: orderId ?? this.orderId,
      technitianId: technitianId ?? this.technitianId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'time': FlutterTimestamp.toMap(time),
      'location': location.toMap(),
      'orderId': orderId,
      'technitianId': technitianId,
    };
  }

  factory TechLiveLocation.fromMap(Map<String, dynamic> map) {
    return TechLiveLocation(
      id: map['id'] as String,
      time: map['time'] as Timestamp,
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      orderId: map['orderId'] as String,
      technitianId: map['technicianId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TechLiveLocation.fromJson(String source) =>
      TechLiveLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  static techLiveLocationsListFromMap(List<Map<String, dynamic>>? techLiveLocationsData) {
    if (techLiveLocationsData == null) return [];
    final techLiveLocations = List<TechLiveLocation>.from((techLiveLocationsData)
        .map<TechLiveLocation>((techLiveLocationData) => TechLiveLocation.fromMap(
              techLiveLocationData,
            ))
        .toList());
    return techLiveLocations;
  }

  @override
  String toString() =>
      'TechLiveLocation(time: $time, location: $location, $id id, $orderId orderId, $technitianId technitianId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TechLiveLocation &&
        other.time == time &&
        other.location == location &&
        other.id == id &&
        other.orderId == orderId;
  }

  @override
  int get hashCode {
    return time.hashCode ^ location.hashCode ^ id.hashCode ^ orderId.hashCode ^ technitianId.hashCode;
  }
}
