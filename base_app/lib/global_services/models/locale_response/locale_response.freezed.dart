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
      _$LocaleResponseCopyWithImpl<$Res>;
  $Res call({bool success, String? message, dynamic data});
}

/// @nodoc
class _$LocaleResponseCopyWithImpl<$Res>
    implements $LocaleResponseCopyWith<$Res> {
  _$LocaleResponseCopyWithImpl(this._value, this._then);

  final LocaleResponse _value;
  // ignore: unused_field
  final $Res Function(LocaleResponse) _then;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_LocaleResponseCopyWith<$Res>
    implements $LocaleResponseCopyWith<$Res> {
  factory _$$_LocaleResponseCopyWith(
          _$_LocaleResponse value, $Res Function(_$_LocaleResponse) then) =
      __$$_LocaleResponseCopyWithImpl<$Res>;
  @override
  $Res call({bool success, String? message, dynamic data});
}

/// @nodoc
class __$$_LocaleResponseCopyWithImpl<$Res>
    extends _$LocaleResponseCopyWithImpl<$Res>
    implements _$$_LocaleResponseCopyWith<$Res> {
  __$$_LocaleResponseCopyWithImpl(
      _$_LocaleResponse _value, $Res Function(_$_LocaleResponse) _then)
      : super(_value, (v) => _then(v as _$_LocaleResponse));

  @override
  _$_LocaleResponse get _value => super._value as _$_LocaleResponse;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_LocaleResponse(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
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
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
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
