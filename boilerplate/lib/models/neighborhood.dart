import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:garage_client/models/location.dart';
import 'package:garage_client/models/exportable.dart';
import 'package:garage_client/models/translatable.dart';

class Neighborhood implements Exportable {
  final String id;
  final Translatable name;
  final String cityId;
  final Location neCoordinates;
  final Location swCoordinates;

  Neighborhood({
    required this.cityId,
    required this.neCoordinates,
    required this.swCoordinates,
    required this.id,
    required this.name,
  });

  Neighborhood copyWith({
    String? id,
    Translatable? name,
    String? cityId,
    Location? neCoordinates,
    Location? swCoordinates,
  }) {
    return Neighborhood(
      id: id ?? this.id,
      name: name ?? this.name,
      cityId: cityId ?? this.cityId,
      neCoordinates: neCoordinates ?? this.neCoordinates,
      swCoordinates: swCoordinates ?? this.swCoordinates,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toMap(),
      'cityId': cityId,
      'neCoordinates': neCoordinates.toMap(),
      'swCoordinates': swCoordinates.toMap(),
    };
  }

  factory Neighborhood.fromMap(Map<String, dynamic> map) {
    return Neighborhood(
      id: map['id'] as String,
      name: Translatable.fromMap(map['name'] as Map<String, dynamic>),
      cityId: map["cityId"] as String,
      neCoordinates: Location.fromMap(map["neCoordinates"] as Map<String, dynamic>),
      swCoordinates: Location.fromMap(map["swCoordinates"] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Neighborhood.fromJson(String source) => Neighborhood.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Neighborhood(id: $id, name: $name, cityId: $cityId, neCoordinates: $neCoordinates, swCoordinates: $swCoordinates)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Neighborhood &&
        other.id == id &&
        other.name == name &&
        other.cityId == cityId &&
        other.neCoordinates == neCoordinates &&
        other.swCoordinates == swCoordinates;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ cityId.hashCode ^ neCoordinates.hashCode ^ swCoordinates.hashCode;
}
