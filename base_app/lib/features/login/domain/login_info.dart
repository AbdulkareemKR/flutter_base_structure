import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_info.freezed.dart';

@freezed
class LoginInfo with _$LoginInfo {
  const factory LoginInfo({
    String? phoneNumber,
    String? otpCode,
    String? loginToken,
    int? otpResendTimer,
    String? newUserName,
    String? userId,
  }) = _LoginInfo;
}
