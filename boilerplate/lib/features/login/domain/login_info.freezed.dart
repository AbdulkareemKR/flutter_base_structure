// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginInfo {
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get otpCode => throw _privateConstructorUsedError;
  String? get loginToken => throw _privateConstructorUsedError;
  int? get otpResendTimer => throw _privateConstructorUsedError;
  String? get newUserName => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginInfoCopyWith<LoginInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginInfoCopyWith<$Res> {
  factory $LoginInfoCopyWith(LoginInfo value, $Res Function(LoginInfo) then) =
      _$LoginInfoCopyWithImpl<$Res>;
  $Res call(
      {String? phoneNumber,
      String? otpCode,
      String? loginToken,
      int? otpResendTimer,
      String? newUserName,
      String? userId});
}

/// @nodoc
class _$LoginInfoCopyWithImpl<$Res> implements $LoginInfoCopyWith<$Res> {
  _$LoginInfoCopyWithImpl(this._value, this._then);

  final LoginInfo _value;
  // ignore: unused_field
  final $Res Function(LoginInfo) _then;

  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? otpCode = freezed,
    Object? loginToken = freezed,
    Object? otpResendTimer = freezed,
    Object? newUserName = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      otpCode: otpCode == freezed
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String?,
      loginToken: loginToken == freezed
          ? _value.loginToken
          : loginToken // ignore: cast_nullable_to_non_nullable
              as String?,
      otpResendTimer: otpResendTimer == freezed
          ? _value.otpResendTimer
          : otpResendTimer // ignore: cast_nullable_to_non_nullable
              as int?,
      newUserName: newUserName == freezed
          ? _value.newUserName
          : newUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_LoginInfoCopyWith<$Res> implements $LoginInfoCopyWith<$Res> {
  factory _$$_LoginInfoCopyWith(
          _$_LoginInfo value, $Res Function(_$_LoginInfo) then) =
      __$$_LoginInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? phoneNumber,
      String? otpCode,
      String? loginToken,
      int? otpResendTimer,
      String? newUserName,
      String? userId});
}

/// @nodoc
class __$$_LoginInfoCopyWithImpl<$Res> extends _$LoginInfoCopyWithImpl<$Res>
    implements _$$_LoginInfoCopyWith<$Res> {
  __$$_LoginInfoCopyWithImpl(
      _$_LoginInfo _value, $Res Function(_$_LoginInfo) _then)
      : super(_value, (v) => _then(v as _$_LoginInfo));

  @override
  _$_LoginInfo get _value => super._value as _$_LoginInfo;

  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? otpCode = freezed,
    Object? loginToken = freezed,
    Object? otpResendTimer = freezed,
    Object? newUserName = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$_LoginInfo(
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      otpCode: otpCode == freezed
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String?,
      loginToken: loginToken == freezed
          ? _value.loginToken
          : loginToken // ignore: cast_nullable_to_non_nullable
              as String?,
      otpResendTimer: otpResendTimer == freezed
          ? _value.otpResendTimer
          : otpResendTimer // ignore: cast_nullable_to_non_nullable
              as int?,
      newUserName: newUserName == freezed
          ? _value.newUserName
          : newUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_LoginInfo implements _LoginInfo {
  const _$_LoginInfo(
      {this.phoneNumber,
      this.otpCode,
      this.loginToken,
      this.otpResendTimer,
      this.newUserName,
      this.userId});

  @override
  final String? phoneNumber;
  @override
  final String? otpCode;
  @override
  final String? loginToken;
  @override
  final int? otpResendTimer;
  @override
  final String? newUserName;
  @override
  final String? userId;

  @override
  String toString() {
    return 'LoginInfo(phoneNumber: $phoneNumber, otpCode: $otpCode, loginToken: $loginToken, otpResendTimer: $otpResendTimer, newUserName: $newUserName, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginInfo &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.otpCode, otpCode) &&
            const DeepCollectionEquality()
                .equals(other.loginToken, loginToken) &&
            const DeepCollectionEquality()
                .equals(other.otpResendTimer, otpResendTimer) &&
            const DeepCollectionEquality()
                .equals(other.newUserName, newUserName) &&
            const DeepCollectionEquality().equals(other.userId, userId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(otpCode),
      const DeepCollectionEquality().hash(loginToken),
      const DeepCollectionEquality().hash(otpResendTimer),
      const DeepCollectionEquality().hash(newUserName),
      const DeepCollectionEquality().hash(userId));

  @JsonKey(ignore: true)
  @override
  _$$_LoginInfoCopyWith<_$_LoginInfo> get copyWith =>
      __$$_LoginInfoCopyWithImpl<_$_LoginInfo>(this, _$identity);
}

abstract class _LoginInfo implements LoginInfo {
  const factory _LoginInfo(
      {final String? phoneNumber,
      final String? otpCode,
      final String? loginToken,
      final int? otpResendTimer,
      final String? newUserName,
      final String? userId}) = _$_LoginInfo;

  @override
  String? get phoneNumber;
  @override
  String? get otpCode;
  @override
  String? get loginToken;
  @override
  int? get otpResendTimer;
  @override
  String? get newUserName;
  @override
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$_LoginInfoCopyWith<_$_LoginInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
