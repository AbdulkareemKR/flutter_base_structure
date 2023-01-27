import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:garage_client/models/location.dart';
import 'package:garage_client/models/exportable.dart';
import 'package:garage_client/models/translatable.dart';
import 'package:garage_client/services/list_services.dart';

class City implements Exportable {
  final String id;
  final Translatable name;
  final List<Location>? cityCircle;
  final String? provinceId;

  City({
    required this.id,
    required this.name,
    required this.cityCircle,
    required this.provinceId,
  });

  City copyWith({
    String? id,
    Translatable? name,
    List<Location>? cityCircle,
    String? provinceId,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      cityCircle: cityCircle ?? this.cityCircle,
      provinceId: provinceId ?? this.provinceId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toMap(),
      'cityCircle': cityCircle != null ? toListOfMap(cityCircle!) : null,
      'provinceId': provinceId,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as String,
      name: Translatable.fromMap(map['name'] as Map<String, dynamic>),
      cityCircle: map['cityCircle'] == null ? null : fromListOfMap(Location.fromMap, map['cityCircle']),
      provinceId: map['provinceId'] == null ? null : map['provinceId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'City(id: $id, name: $name, cityCircle: $cityCircle, provinceId: $provinceId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is City &&
        other.id == id &&
        other.name == name &&
        listEquals(other.cityCircle, cityCircle) &&
        other.provinceId == provinceId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ cityCircle.hashCode ^ provinceId.hashCode;
}
