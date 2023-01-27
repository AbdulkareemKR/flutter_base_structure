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
      _$CloudFunctionsResponseCopyWithImpl<$Res, CloudFunctionsResponse>;
  @useResult
  $Res call({bool success, String message, dynamic data});
}

/// @nodoc
class _$CloudFunctionsResponseCopyWithImpl<$Res,
        $Val extends CloudFunctionsResponse>
    implements $CloudFunctionsResponseCopyWith<$Res> {
  _$CloudFunctionsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CloudFunctionsResponseCopyWith<$Res>
    implements $CloudFunctionsResponseCopyWith<$Res> {
  factory _$$_CloudFunctionsResponseCopyWith(_$_CloudFunctionsResponse value,
          $Res Function(_$_CloudFunctionsResponse) then) =
      __$$_CloudFunctionsResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, dynamic data});
}

/// @nodoc
class __$$_CloudFunctionsResponseCopyWithImpl<$Res>
    extends _$CloudFunctionsResponseCopyWithImpl<$Res,
        _$_CloudFunctionsResponse>
    implements _$$_CloudFunctionsResponseCopyWith<$Res> {
  __$$_CloudFunctionsResponseCopyWithImpl(_$_CloudFunctionsResponse _value,
      $Res Function(_$_CloudFunctionsResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$_CloudFunctionsResponse(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
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
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
