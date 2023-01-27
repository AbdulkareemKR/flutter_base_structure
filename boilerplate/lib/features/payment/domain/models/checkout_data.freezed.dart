// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'checkout_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheckoutData _$CheckoutDataFromJson(Map<String, dynamic> json) {
  return _CheckoutData.fromJson(json);
}

/// @nodoc
mixin _$CheckoutData {
  String get checkoutId => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckoutDataCopyWith<CheckoutData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutDataCopyWith<$Res> {
  factory $CheckoutDataCopyWith(
          CheckoutData value, $Res Function(CheckoutData) then) =
      _$CheckoutDataCopyWithImpl<$Res>;
  $Res call({String checkoutId, num amount});
}

/// @nodoc
class _$CheckoutDataCopyWithImpl<$Res> implements $CheckoutDataCopyWith<$Res> {
  _$CheckoutDataCopyWithImpl(this._value, this._then);

  final CheckoutData _value;
  // ignore: unused_field
  final $Res Function(CheckoutData) _then;

  @override
  $Res call({
    Object? checkoutId = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      checkoutId: checkoutId == freezed
          ? _value.checkoutId
          : checkoutId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$$_CheckoutDataCopyWith<$Res>
    implements $CheckoutDataCopyWith<$Res> {
  factory _$$_CheckoutDataCopyWith(
          _$_CheckoutData value, $Res Function(_$_CheckoutData) then) =
      __$$_CheckoutDataCopyWithImpl<$Res>;
  @override
  $Res call({String checkoutId, num amount});
}

/// @nodoc
class __$$_CheckoutDataCopyWithImpl<$Res>
    extends _$CheckoutDataCopyWithImpl<$Res>
    implements _$$_CheckoutDataCopyWith<$Res> {
  __$$_CheckoutDataCopyWithImpl(
      _$_CheckoutData _value, $Res Function(_$_CheckoutData) _then)
      : super(_value, (v) => _then(v as _$_CheckoutData));

  @override
  _$_CheckoutData get _value => super._value as _$_CheckoutData;

  @override
  $Res call({
    Object? checkoutId = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$_CheckoutData(
      checkoutId: checkoutId == freezed
          ? _value.checkoutId
          : checkoutId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheckoutData implements _CheckoutData {
  _$_CheckoutData({required this.checkoutId, required this.amount});

  factory _$_CheckoutData.fromJson(Map<String, dynamic> json) =>
      _$$_CheckoutDataFromJson(json);

  @override
  final String checkoutId;
  @override
  final num amount;

  @override
  String toString() {
    return 'CheckoutData(checkoutId: $checkoutId, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheckoutData &&
            const DeepCollectionEquality()
                .equals(other.checkoutId, checkoutId) &&
            const DeepCollectionEquality().equals(other.amount, amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(checkoutId),
      const DeepCollectionEquality().hash(amount));

  @JsonKey(ignore: true)
  @override
  _$$_CheckoutDataCopyWith<_$_CheckoutData> get copyWith =>
      __$$_CheckoutDataCopyWithImpl<_$_CheckoutData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckoutDataToJson(
      this,
    );
  }
}

abstract class _CheckoutData implements CheckoutData {
  factory _CheckoutData(
      {required final String checkoutId,
      required final num amount}) = _$_CheckoutData;

  factory _CheckoutData.fromJson(Map<String, dynamic> json) =
      _$_CheckoutData.fromJson;

  @override
  String get checkoutId;
  @override
  num get amount;
  @override
  @JsonKey(ignore: true)
  _$$_CheckoutDataCopyWith<_$_CheckoutData> get copyWith =>
      throw _privateConstructorUsedError;
}
