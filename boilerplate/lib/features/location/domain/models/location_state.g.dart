// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationState _$$_LocationStateFromJson(Map<String, dynamic> json) =>
    _$_LocationState(
      isBeingEditedLocation: json['isBeingEditedLocation'] as bool?,
      editedLocationId: json['editedLocationId'] as String?,
      viewMode: $enumDecode(_$LocationViewModeEnumMap, json['viewMode']),
    );

Map<String, dynamic> _$$_LocationStateToJson(_$_LocationState instance) =>
    <String, dynamic>{
      'isBeingEditedLocation': instance.isBeingEditedLocation,
      'editedLocationId': instance.editedLocationId,
      'viewMode': _$LocationViewModeEnumMap[instance.viewMode]!,
    };

const _$LocationViewModeEnumMap = {
  LocationViewMode.add: 'add',
  LocationViewMode.edit: 'edit',
  LocationViewMode.view: 'view',
};
