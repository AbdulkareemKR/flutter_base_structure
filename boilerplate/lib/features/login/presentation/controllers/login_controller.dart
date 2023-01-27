import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/login/domain/login_providers.dart';
import 'package:garage_client/features/login/presentation/screens/new_user_screen.dart';
import 'package:garage_client/data/repos/auth_repo.dart';
import 'package:garage_client/features/login/presentation/screens/otp_screen.dart';
import 'package:garage_client/widgets/otp_text_field/otp_textfield.dart';
import 'package:garage_client/services/auth_services.dart';
import 'package:garage_client/services/car_owner_repo.dart';
import 'package:garage_client/services/easy_navigator.dart';
import 'package:garage_client/services/validator.dart';
import 'package:garage_client/widgets/bottom_sheet/bottom_sheet_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:garage_client/localization/localization.dart';

final loginScreenControllerProvider = StateNotifierProvider<LoginController, AsyncValue<void>>(
  (ref) => LoginController(const AsyncValue.loading(), authRepo: ref.watch(authRepo), ref: ref),
);

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController(AsyncValue<void> state, {required this.authRepo, required this.ref}) : super(state);
  final FirebaseAuthServices authRepo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Ref ref;
  late BuildContext context;

  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey();
  final GlobalKey<FormState> otpCodeFormKey = GlobalKey();
  final GlobalKey<OTPTextFieldState> otpTextFieldKey = GlobalKey<OTPTextFieldState>();

  String? phoneNumberValidator(String? phoneNumber) {
    String truncatedPhoneNumber = (phoneNumber != null && phoneNumber.isNotEmpty ? phoneNumber.substring(1) : "");
    String completePhoneNumber = "+966" + truncatedPhoneNumber;

    if (!Validator.isValidPhoneNumber(completePhoneNumber)) {
      return "errors.incorrectNumber".translate();
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    super.dispose();
  }

  void onContinuePressed() {
    if (phoneNumberFormKey.currentState?.validate() ?? false) {
      sendOtpCode();
      EasyNavigator.openPage(context: context, page: const OtpScreen());
    }
  }

  void sendOtpCode() {
    handleOtpSendDuration();

    FirebaseAuthServices.instance.verifyPhoneNumber(
        phoneNumber: '+966${ref.read(loginInfoProvider)?.phoneNumber?.substring(1)}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          await FirebaseAuthServices.instance.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          GLogger.error('$e');
        },
        codeSent: (String verificationId, int? resendToken) async {
          GLogger.debug('code sent');
          GLogger.debug('VerificationId = $verificationId');
          ref.read(loginInfoProvider.notifier).updateLoginToken(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void handleOtpSendDuration() async {
    ref.read(timerToResend.state).state = 59;
    Timer.periodic(const Duration(seconds: 1), ((timer) {
      ref.read(timerToResend.notifier).state--;
      if (ref.read(timerToResend) < 1) {
        ref.read(allowResendOtpProvider.notifier).state = true;
        timer.cancel();
      }
    }));
  }

  void onResendOtpPressed() {
    if (ref.read(allowResendOtpProvider.notifier).state == true) {
      ref.read(allowResendOtpProvider.notifier).state = false;
      sendOtpCode();
    }
  }

  void changeOtpFieldFocus(bool isFocused) {
    ref.read(isFocusedOtpFieldProvider.state).state = isFocused;
  }

  String? otpFieldValidator(String? otpCode) {
    // validator will always return an empty error message to indicate error in the otp. if we return some string in the validator, it will appear in all otp fields, so we have to use a separate independent message
    return "";
  }

  Future<void> onOtpCheckButtonPressed() async {
    if (await isValidOtp()) {
      await addUserToFirestore();
      ref.read(isValidOtpProvider.notifier).state = true;

      final carOwner =
          await ref.watch(carOwnerRepoProvider).getCarOwnerFromId(ref.read(loginInfoProvider)?.userId ?? "");

      if (!Validator.safeIsNotEmpty(carOwner?.name)) {
        await EasyNavigator.openPage(
          page: const NewUserScreen(),
          isDismissible: false,
          context: context,
        );
      }

      EasyNavigator.popToFirstView(context); //Pop to Home View

    } else {
      otpCodeFormKey.currentState?.validate();
      ref.read(isValidOtpProvider.notifier).state = false;
    }
  }

  Future<bool> isValidOtp() async {
    try {
      final otp = (otpTextFieldKey.currentState as OTPTextFieldState).value;
      final credential =
          PhoneAuthProvider.credential(verificationId: ref.read(loginInfoProvider)?.loginToken ?? "", smsCode: otp);

      final user = await authRepo.singInWithPhoneNumber(credential);

      if (user != null) {
        ref.read(loginInfoProvider.notifier).addUserId(user.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      GLogger.error(e.toString());
      return false;
    }
  }

  Future<void> addUserToFirestore() async {
    final carOwner = await ref.watch(carOwnerRepoProvider).getCarOwnerFromId(ref.read(loginInfoProvider)?.userId ?? "");

    if (carOwner == null) {
      String userName = nameController.text;
      String phoneNumber = '+966${ref.read(loginInfoProvider)?.phoneNumber?.substring(1)}';
      await ref.read(carOwnerRepoProvider).createCarOwner(ref.read(loginInfoProvider)!.userId!, userName, phoneNumber);
    }
  }

  Future<void> updateUserName() async {
    await ref
        .read(carOwnerRepoProvider)
        .changeUserName(FirebaseAuthServices.instance.currentUser!.uid, nameController.text);
  }
}
