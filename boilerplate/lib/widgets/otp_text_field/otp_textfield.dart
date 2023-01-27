import 'package:flutter/material.dart';
import 'package:garage_client/widgets/otp_text_field/otp_field.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

/// An OTP Text field
class OTPTextField extends StatefulWidget {
  /// Function to be called when the the user has entered the last OTP field
  final void Function() onComplete;

  /// Number of OTP fields to be displayed
  final int fieldsCount;

  late final List<GlobalKey<OtpFieldState>> otpFieldKeys;
  late final List<FocusNode> focusNodes;
  final String? Function(String?)? validator;

  OTPTextField({Key? key, required this.onComplete, this.fieldsCount = 6, this.validator}) : super(key: key) {
    otpFieldKeys =
        List<GlobalKey<OtpFieldState>>.generate(fieldsCount, (index) => GlobalKey<OtpFieldState>(debugLabel: "$index"));

    focusNodes = List<FocusNode>.generate(fieldsCount, (index) => FocusNode(debugLabel: "$index"));
  }

  @override
  State<OTPTextField> createState() => OTPTextFieldState();
}

class OTPTextFieldState extends State<OTPTextField> {
  /// Return all OTP fields as a one string
  String get value {
    return widget.otpFieldKeys.map((otpFieldKey) => otpFieldKey.currentState?.value ?? '').join();
  }

  void onAutoFill(String? otp) {
    GLogger.info("Got auto fill OTP: $otp");

    if ((otp?.length ?? 0) >= widget.fieldsCount) {
      for (int index = 0; index < otp!.length; index++) {
        widget.otpFieldKeys[index].currentState?.text = otp[index];
      }

      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              widget.fieldsCount,
              (index) => OtpField(
                    validator: widget.validator,
                    onAutoFill: onAutoFill,
                    callback: widget.onComplete,
                    fieldIndex: index,
                    focusNodes: widget.focusNodes,
                    key: widget.otpFieldKeys[index],
                  ))),
    );
  }
}
