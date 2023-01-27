import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:garage_client/enums/car_class.dart';
import 'package:garage_client/enums/car_type.dart';
import 'package:garage_client/models/exportable.dart';
import 'package:garage_client/services/enum_services.dart';

class AvailableService implements Exportable {
  final String id;
  double price;
  final List<CarType>? carTypes;
  final List<CarClass>? carClasses;
  final String? note;

  AvailableService({
    this.note,
    required this.id,
    required this.price,
    required this.carTypes,
    required this.carClasses,
  });

  AvailableService copyWith({
    String? id,
    double? price,
    List<CarType>? carTypes,
    List<CarClass>? carClasses,
    String? note,
  }) {
    return AvailableService(
      id: id ?? this.id,
      price: price ?? this.price,
      carTypes: carTypes ?? this.carTypes,
      carClasses: carClasses ?? this.carClasses,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'carTypes': enumToList(carTypes),
      'carClasses': enumToList(carClasses),
      "note": note,
    };
  }

  factory AvailableService.fromMap(Map<String, dynamic> map) {
    return AvailableService(
      id: map['id'] as String,
      price: double.parse((map['price'] as num).toStringAsFixed(2)),
      carTypes: map['carTypes'] != null ? enumFromList(CarType.values, map['carTypes']) : null,
      carClasses: map['carClasses'] != null ? enumFromList(CarClass.values, map['carClasses']) : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableService.fromJson(String source) =>
      AvailableService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AvailableService(id: $id, price: $price, carTypes: $carTypes, carClasses: $carClasses, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is AvailableService &&
        other.id == id &&
        other.price == price &&
        listEquals(other.carTypes, carTypes) &&
        listEquals(other.carClasses, carClasses) &&
        other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^ price.hashCode ^ carTypes.hashCode ^ carClasses.hashCode ^ note.hashCode;
  }
}
