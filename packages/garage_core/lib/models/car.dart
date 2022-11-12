import 'dart:convert';

import 'package:garage_core/enums/car_class.dart';
import 'package:garage_core/enums/car_type.dart';
import 'package:garage_core/models/translatable.dart';
import 'package:garage_core/services/enum_services.dart';

export 'package:garage_core/enums/car_class.dart';
export 'package:garage_core/enums/car_type.dart';

class Car {
  String id;
  Translatable company;
  Translatable brand;
  CarType type;
  CarClass carClass;
  Car({
    required this.id,
    required this.company,
    required this.brand,
    required this.type,
    required this.carClass,
  });

  Car copyWith({
    String? id,
    Translatable? company,
    Translatable? brand,
    CarType? type,
    CarClass? carClass,
  }) {
    return Car(
      id: id ?? this.id,
      company: company ?? this.company,
      brand: brand ?? this.brand,
      type: type ?? this.type,
      carClass: carClass ?? this.carClass,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'company': company.toMap(),
      'brand': brand.toMap(),
      'type': enumToString(type),
      'carClass': enumToString(carClass),
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] as String,
      company: Translatable.fromMap(map['company']),
      brand: Translatable.fromMap(map['brand']),
      type: enumFromString(CarType.values, map['type'] as String),
      carClass: enumFromString(CarClass.values, map['carClass'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Car(id: $id, company: $company, brand: $brand, type: $type, carClass: $carClass)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Car &&
        other.id == id &&
        other.company == company &&
        other.brand == brand &&
        other.type == type &&
        other.carClass == carClass;
  }

  @override
  int get hashCode => id.hashCode ^ company.hashCode ^ brand.hashCode ^ type.hashCode ^ carClass.hashCode;
}
