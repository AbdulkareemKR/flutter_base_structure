// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'locale_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocaleResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocaleResponseCopyWith<LocaleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocaleResponseCopyWith<$Res> {
  factory $LocaleResponseCopyWith(
          LocaleResponse value, $Res Function(LocaleResponse) then) =
      _$LocaleResponseCopyWithImpl<$Res, LocaleResponse>;
  @useResult
  $Res call({bool success, String? message, dynamic data});
}

/// @nodoc
class _$LocaleResponseCopyWithImpl<$Res, $Val extends LocaleResponse>
    implements $LocaleResponseCopyWith<$Res> {
  _$LocaleResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocaleResponseCopyWith<$Res>
    implements $LocaleResponseCopyWith<$Res> {
  factory _$$_LocaleResponseCopyWith(
          _$_LocaleResponse value, $Res Function(_$_LocaleResponse) then) =
      __$$_LocaleResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, dynamic data});
}

/// @nodoc
class __$$_LocaleResponseCopyWithImpl<$Res>
    extends _$LocaleResponseCopyWithImpl<$Res, _$_LocaleResponse>
    implements _$$_LocaleResponseCopyWith<$Res> {
  __$$_LocaleResponseCopyWithImpl(
      _$_LocaleResponse _value, $Res Function(_$_LocaleResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(_$_LocaleResponse(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_LocaleResponse implements _LocaleResponse {
  const _$_LocaleResponse({required this.success, this.message, this.data});

  @override
  final bool success;
  @override
  final String? message;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'LocaleResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocaleResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocaleResponseCopyWith<_$_LocaleResponse> get copyWith =>
      __$$_LocaleResponseCopyWithImpl<_$_LocaleResponse>(this, _$identity);
}

abstract class _LocaleResponse implements LocaleResponse {
  const factory _LocaleResponse(
      {required final bool success,
      final String? message,
      final dynamic data}) = _$_LocaleResponse;

  @override
  bool get success;
  @override
  String? get message;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$_LocaleResponseCopyWith<_$_LocaleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
