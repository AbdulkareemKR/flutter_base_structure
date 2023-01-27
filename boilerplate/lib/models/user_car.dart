import 'dart:convert';

import 'package:garage_client/models/color.dart';
import 'package:garage_client/models/plate.dart';
import 'package:garage_client/services/car_services.dart';

class UserCar {
  final String? id;
  final String uid;
  String? carId;
  CarColor? color;
  String? modelYear;
  Plate? plate;
  UserCar({
    this.id,
    required this.uid,
    this.carId,
    this.color,
    this.modelYear,
    this.plate,
  });

  UserCar copyWith({
    String? id,
    String? uid,
    String? carId,
    CarColor? color,
    String? modelYear,
    Plate? plate,
  }) {
    return UserCar(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      carId: carId ?? this.carId,
      color: color ?? this.color,
      modelYear: modelYear ?? this.modelYear,
      plate: plate ?? this.plate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'carId': carId,
      'color': color?.toMap(),
      'modelYear': modelYear,
      'plate': plate?.toMap(),
    };
  }

  factory UserCar.fromMap(Map<String, dynamic> map) {
    return UserCar(
      id: map['id'] as String,
      uid: map['uid'] as String,
      carId: map['carId'] as String,
      color: CarColor.fromMap(map['color'] as Map<String, dynamic>),
      modelYear: map['modelYear'] as String,
      plate: Plate.fromMap(map['plate'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCar.fromJson(String source) => UserCar.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserCar(id: $id, uid: $uid, carId: $carId, color: $color, modelYear: $modelYear, plate: $plate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserCar &&
        other.id == id &&
        other.uid == uid &&
        other.carId == carId &&
        other.color == color &&
        other.modelYear == modelYear &&
        other.plate == plate;
  }

  String get name => getCarName(carId!);
  @override
  int get hashCode {
    return id.hashCode ^ uid.hashCode ^ carId.hashCode ^ color.hashCode ^ modelYear.hashCode ^ plate.hashCode;
  }

  String get plateString => '${(plate?.letters.split('').join(' ') ?? '')} | ${(plate?.numbers ?? '')}';
}
