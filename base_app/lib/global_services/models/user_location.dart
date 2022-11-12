import 'dart:convert';

import 'package:garage_client/global_services/models/exportable.dart';

class UserLocation implements Exportable {
  String? id;
  double latitude;
  double longitude;
  final String cityId;
  String? note;
  final String title;

  UserLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.cityId,
    this.note,
    required this.title,
  });

  UserLocation copyWith({
    String? id,
    double? latitude,
    double? longitude,
    String? cityId,
    String? note,
    String? title,
  }) {
    return UserLocation(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityId: cityId ?? this.cityId,
      note: note ?? this.note,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'cityId': cityId,
      'note': note,
      'title': title,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      id: map['id'] != null ? map['id'] as String : null,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      cityId: map['cityId'].toString(),
      note: map['note'] != null ? map['note'] as String : null,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocation.fromJson(String source) => UserLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserLocation(id: $id,  latitude: $latitude, longitude: $longitude, cityId: $cityId, note: $note, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLocation && other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^ longitude.hashCode ^ cityId.hashCode ^ note.hashCode ^ title.hashCode ^ id.hashCode;
  }
}
