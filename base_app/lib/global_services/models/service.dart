import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:garage_core/enums/car_class.dart';
import 'package:garage_core/enums/car_type.dart';
import 'package:garage_core/models/cloud_image.dart';
import 'package:garage_core/models/price_range.dart';
import 'package:garage_core/models/translatable.dart';
import 'package:garage_core/services/enum_services.dart';

export 'package:garage_core/enums/car_type.dart';
export 'package:garage_core/models/price_range.dart';

class Service {
  final String id;
  final Translatable name;
  final Translatable description;
  final String? parent;
  final CloudImage logo;
  final List<CarType> carTypes;
  final PriceRange priceRange;
  final List<CarClass>? carClasses;

  Service({
    required this.id,
    required this.name,
    required this.description,
    this.parent,
    required this.logo,
    required this.carTypes,
    required this.priceRange,
    required this.carClasses,
  });

  Service copyWith({
    String? id,
    Translatable? name,
    Translatable? description,
    String? parent,
    CloudImage? logo,
    List<CarType>? carTypes,
    PriceRange? priceRange,
    List<CarClass>? carClasses,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parent: parent ?? this.parent,
      logo: logo ?? this.logo,
      carTypes: carTypes ?? this.carTypes,
      priceRange: priceRange ?? this.priceRange,
      carClasses: carClasses ?? this.carClasses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toMap(),
      'description': description.toMap(),
      'parent': parent,
      'logo': logo.toMap(),
      'carTypes': enumToList(carTypes),
      'priceRange': priceRange.toMap(),
      'carClasses': enumToList(carClasses),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      name: Translatable.fromMap(map['name'] as Map<String, dynamic>),
      description: Translatable.fromMap(map['description'] as Map<String, dynamic>),
      parent: map['parent'] != null ? map['parent'] as String : null,
      logo: CloudImage.fromMap(map['logo'] as Map<String, dynamic>),
      carTypes: enumFromList(CarType.values, map['carTypes']),
      priceRange: PriceRange.fromMap(map['priceRange'] as Map<String, dynamic>),
      carClasses: enumFromList(CarClass.values, map['carClasses']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) => Service.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Service(id: $id, name: $name, description: $description, parent: $parent, logo: $logo, carTypes: $carTypes, priceRange: $priceRange, carClasses: $carClasses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Service &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.parent == parent &&
        other.logo == logo &&
        listEquals(other.carTypes, carTypes) &&
        other.priceRange == priceRange &&
        listEquals(other.carClasses, carClasses);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        parent.hashCode ^
        logo.hashCode ^
        carTypes.hashCode ^
        priceRange.hashCode ^
        carClasses.hashCode;
  }
}
