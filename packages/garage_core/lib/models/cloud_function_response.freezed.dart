// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cloud_function_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CloudFunctionsResponse _$CloudFunctionsResponseFromJson(
    Map<String, dynamic> json) {
  return _CloudFunctionsResponse.fromJson(json);
}

/// @nodoc
mixin _$CloudFunctionsResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CloudFunctionsResponseCopyWith<CloudFunctionsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudFunctionsResponseCopyWith<$Res> {
  factory $CloudFunctionsResponseCopyWith(CloudFunctionsResponse value,
          $Res Function(CloudFunctionsResponse) then) =
      _$CloudFunctionsResponseCopyWithImpl<$Res>;
  $Res call({bool success, String message, dynamic data});
}

/// @nodoc
class _$CloudFunctionsResponseCopyWithImpl<$Res>
    implements $CloudFunctionsResponseCopyWith<$Res> {
  _$CloudFunctionsResponseCopyWithImpl(this._value, this._then);

  final CloudFunctionsResponse _value;
  // ignore: unused_field
  final $Res Function(CloudFunctionsResponse) _then;

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
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_CloudFunctionsResponseCopyWith<$Res>
    implements $CloudFunctionsResponseCopyWith<$Res> {
  factory _$$_CloudFunctionsResponseCopyWith(_$_CloudFunctionsResponse value,
          $Res Function(_$_CloudFunctionsResponse) then) =
      __$$_CloudFunctionsResponseCopyWithImpl<$Res>;
  @override
  $Res call({bool success, String message, dynamic data});
}

/// @nodoc
class __$$_CloudFunctionsResponseCopyWithImpl<$Res>
    extends _$CloudFunctionsResponseCopyWithImpl<$Res>
    implements _$$_CloudFunctionsResponseCopyWith<$Res> {
  __$$_CloudFunctionsResponseCopyWithImpl(_$_CloudFunctionsResponse _value,
      $Res Function(_$_CloudFunctionsResponse) _then)
      : super(_value, (v) => _then(v as _$_CloudFunctionsResponse));

  @override
  _$_CloudFunctionsResponse get _value =>
      super._value as _$_CloudFunctionsResponse;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_CloudFunctionsResponse(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CloudFunctionsResponse implements _CloudFunctionsResponse {
  _$_CloudFunctionsResponse(
      {required this.success, required this.message, required this.data});

  factory _$_CloudFunctionsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CloudFunctionsResponseFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'CloudFunctionsResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CloudFunctionsResponse &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_CloudFunctionsResponseCopyWith<_$_CloudFunctionsResponse> get copyWith =>
      __$$_CloudFunctionsResponseCopyWithImpl<_$_CloudFunctionsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CloudFunctionsResponseToJson(
      this,
    );
  }
}

abstract class _CloudFunctionsResponse implements CloudFunctionsResponse {
  factory _CloudFunctionsResponse(
      {required final bool success,
      required final String message,
      required final dynamic data}) = _$_CloudFunctionsResponse;

  factory _CloudFunctionsResponse.fromJson(Map<String, dynamic> json) =
      _$_CloudFunctionsResponse.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$_CloudFunctionsResponseCopyWith<_$_CloudFunctionsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
