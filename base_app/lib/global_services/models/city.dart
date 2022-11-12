import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:garage_client/global_services/models/location.dart';
import 'package:garage_client/global_services/models/exportable.dart';
import 'package:garage_client/global_services/models/translatable.dart';
import 'package:garage_client/global_services/services/list_services.dart';

class City implements Exportable {
  final String id;
  final Translatable name;
  final List<Location>? cityCircle;
  City({
    required this.id,
    required this.name,
    required this.cityCircle,
  });

  City copyWith({
    String? id,
    Translatable? name,
    List<Location>? cityCircle,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      cityCircle: cityCircle ?? this.cityCircle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toMap(),
      'cityCircle': cityCircle != null ? toListOfMap(cityCircle!) : null,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as String,
      name: Translatable.fromMap(map['name'] as Map<String, dynamic>),
      cityCircle: map['cityCircle'] == null ? null : fromListOfMap(Location.fromMap, map['cityCircle']),
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'City(id: $id, name: $name, cityCircle: $cityCircle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is City && other.id == id && other.name == name && listEquals(other.cityCircle, cityCircle);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ cityCircle.hashCode;
}
