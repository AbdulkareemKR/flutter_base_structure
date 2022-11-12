// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrderRatingInfo {
  String? get orderId => throw _privateConstructorUsedError;
  int? get rating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderRatingInfoCopyWith<OrderRatingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderRatingInfoCopyWith<$Res> {
  factory $OrderRatingInfoCopyWith(
          OrderRatingInfo value, $Res Function(OrderRatingInfo) then) =
      _$OrderRatingInfoCopyWithImpl<$Res>;
  $Res call({String? orderId, int? rating, String? comment});
}

/// @nodoc
class _$OrderRatingInfoCopyWithImpl<$Res>
    implements $OrderRatingInfoCopyWith<$Res> {
  _$OrderRatingInfoCopyWithImpl(this._value, this._then);

  final OrderRatingInfo _value;
  // ignore: unused_field
  final $Res Function(OrderRatingInfo) _then;

  @override
  $Res call({
    Object? orderId = freezed,
    Object? rating = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_OrderRatingInfoCopyWith<$Res>
    implements $OrderRatingInfoCopyWith<$Res> {
  factory _$$_OrderRatingInfoCopyWith(
          _$_OrderRatingInfo value, $Res Function(_$_OrderRatingInfo) then) =
      __$$_OrderRatingInfoCopyWithImpl<$Res>;
  @override
  $Res call({String? orderId, int? rating, String? comment});
}

/// @nodoc
class __$$_OrderRatingInfoCopyWithImpl<$Res>
    extends _$OrderRatingInfoCopyWithImpl<$Res>
    implements _$$_OrderRatingInfoCopyWith<$Res> {
  __$$_OrderRatingInfoCopyWithImpl(
      _$_OrderRatingInfo _value, $Res Function(_$_OrderRatingInfo) _then)
      : super(_value, (v) => _then(v as _$_OrderRatingInfo));

  @override
  _$_OrderRatingInfo get _value => super._value as _$_OrderRatingInfo;

  @override
  $Res call({
    Object? orderId = freezed,
    Object? rating = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$_OrderRatingInfo(
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_OrderRatingInfo implements _OrderRatingInfo {
  const _$_OrderRatingInfo({this.orderId, this.rating, this.comment});

  @override
  final String? orderId;
  @override
  final int? rating;
  @override
  final String? comment;

  @override
  String toString() {
    return 'OrderRatingInfo(orderId: $orderId, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderRatingInfo &&
            const DeepCollectionEquality().equals(other.orderId, orderId) &&
            const DeepCollectionEquality().equals(other.rating, rating) &&
            const DeepCollectionEquality().equals(other.comment, comment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(orderId),
      const DeepCollectionEquality().hash(rating),
      const DeepCollectionEquality().hash(comment));

  @JsonKey(ignore: true)
  @override
  _$$_OrderRatingInfoCopyWith<_$_OrderRatingInfo> get copyWith =>
      __$$_OrderRatingInfoCopyWithImpl<_$_OrderRatingInfo>(this, _$identity);
}

abstract class _OrderRatingInfo implements OrderRatingInfo {
  const factory _OrderRatingInfo(
      {final String? orderId,
      final int? rating,
      final String? comment}) = _$_OrderRatingInfo;

  @override
  String? get orderId;
  @override
  int? get rating;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$_OrderRatingInfoCopyWith<_$_OrderRatingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
