// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_form_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CarFormState _$$_CarFormStateFromJson(Map<String, dynamic> json) =>
    _$_CarFormState(
      viewMode: $enumDecode(_$CarViewModeEnumMap, json['viewMode']),
      carBrand: Translatable.fromJson(json['carBrand'] as String),
      carType: json['carType'] as String,
      selectedCar: json['selectedCar'] == null
          ? null
          : Car.fromJson(json['selectedCar'] as String),
      selectedColor: json['selectedColor'] == null
          ? null
          : CarColor.fromJson(json['selectedColor'] as String),
    );

Map<String, dynamic> _$$_CarFormStateToJson(_$_CarFormState instance) =>
    <String, dynamic>{
      'viewMode': _$CarViewModeEnumMap[instance.viewMode]!,
      'carBrand': instance.carBrand,
      'carType': instance.carType,
      'selectedCar': instance.selectedCar,
      'selectedColor': instance.selectedColor,
    };

const _$CarViewModeEnumMap = {
  CarViewMode.edit: 'edit',
  CarViewMode.add: 'add',
};
