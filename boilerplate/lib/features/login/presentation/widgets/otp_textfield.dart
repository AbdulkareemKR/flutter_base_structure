import 'package:flutter/material.dart';
import 'package:garage_client/features/login/presentation/widgets/otp_field.dart';

/// An OTP Text field
class OTPTextField extends StatefulWidget {
  /// Function to be called when the the user has entered the last OTP field
  final void Function() onComplete;

  /// Number of OTP fields to be displayed
  final int fieldsCount;

  late final List<GlobalKey<OtpFieldState>> otpFieldKeys;
  late final List<FocusNode> focusNodes;

  OTPTextField({Key? key, required this.onComplete, this.fieldsCount = 6}) : super(key: key) {
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              widget.fieldsCount,
              (index) => OtpField(
                    callback: widget.onComplete,
                    fieldIndex: index,
                    focusNodes: widget.focusNodes,
                    key: widget.otpFieldKeys[index],
                  ))),
    );
  }
}
