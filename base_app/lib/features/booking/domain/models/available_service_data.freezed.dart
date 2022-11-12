// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'available_service_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AvailableServiceData {
  String get serviceId => throw _privateConstructorUsedError;
  String get serviceProviderId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AvailableServiceDataCopyWith<AvailableServiceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableServiceDataCopyWith<$Res> {
  factory $AvailableServiceDataCopyWith(AvailableServiceData value,
          $Res Function(AvailableServiceData) then) =
      _$AvailableServiceDataCopyWithImpl<$Res>;
  $Res call({String serviceId, String serviceProviderId});
}

/// @nodoc
class _$AvailableServiceDataCopyWithImpl<$Res>
    implements $AvailableServiceDataCopyWith<$Res> {
  _$AvailableServiceDataCopyWithImpl(this._value, this._then);

  final AvailableServiceData _value;
  // ignore: unused_field
  final $Res Function(AvailableServiceData) _then;

  @override
  $Res call({
    Object? serviceId = freezed,
    Object? serviceProviderId = freezed,
  }) {
    return _then(_value.copyWith(
      serviceId: serviceId == freezed
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceProviderId: serviceProviderId == freezed
          ? _value.serviceProviderId
          : serviceProviderId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ServicePriceDataCopyWith<$Res>
    implements $AvailableServiceDataCopyWith<$Res> {
  factory _$$_ServicePriceDataCopyWith(
          _$_ServicePriceData value, $Res Function(_$_ServicePriceData) then) =
      __$$_ServicePriceDataCopyWithImpl<$Res>;
  @override
  $Res call({String serviceId, String serviceProviderId});
}

/// @nodoc
class __$$_ServicePriceDataCopyWithImpl<$Res>
    extends _$AvailableServiceDataCopyWithImpl<$Res>
    implements _$$_ServicePriceDataCopyWith<$Res> {
  __$$_ServicePriceDataCopyWithImpl(
      _$_ServicePriceData _value, $Res Function(_$_ServicePriceData) _then)
      : super(_value, (v) => _then(v as _$_ServicePriceData));

  @override
  _$_ServicePriceData get _value => super._value as _$_ServicePriceData;

  @override
  $Res call({
    Object? serviceId = freezed,
    Object? serviceProviderId = freezed,
  }) {
    return _then(_$_ServicePriceData(
      serviceId: serviceId == freezed
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceProviderId: serviceProviderId == freezed
          ? _value.serviceProviderId
          : serviceProviderId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ServicePriceData implements _ServicePriceData {
  _$_ServicePriceData(
      {required this.serviceId, required this.serviceProviderId});

  @override
  final String serviceId;
  @override
  final String serviceProviderId;

  @override
  String toString() {
    return 'AvailableServiceData(serviceId: $serviceId, serviceProviderId: $serviceProviderId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ServicePriceData &&
            const DeepCollectionEquality().equals(other.serviceId, serviceId) &&
            const DeepCollectionEquality()
                .equals(other.serviceProviderId, serviceProviderId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(serviceId),
      const DeepCollectionEquality().hash(serviceProviderId));

  @JsonKey(ignore: true)
  @override
  _$$_ServicePriceDataCopyWith<_$_ServicePriceData> get copyWith =>
      __$$_ServicePriceDataCopyWithImpl<_$_ServicePriceData>(this, _$identity);
}

abstract class _ServicePriceData implements AvailableServiceData {
  factory _ServicePriceData(
      {required final String serviceId,
      required final String serviceProviderId}) = _$_ServicePriceData;

  @override
  String get serviceId;
  @override
  String get serviceProviderId;
  @override
  @JsonKey(ignore: true)
  _$$_ServicePriceDataCopyWith<_$_ServicePriceData> get copyWith =>
      throw _privateConstructorUsedError;
}
