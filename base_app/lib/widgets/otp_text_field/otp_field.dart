import 'package:flutter/material.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/widgets/otp_text_field/otp_controller.dart';
import 'package:garage_core/constants/constants.dart';
import 'package:garage_client/utils/theme/extensions.dart';

class OtpField extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final int fieldIndex;
  final void Function() callback;
  final String? Function(String?)? validator;
  final void Function(String?) onAutoFill;

  const OtpField({
    required this.callback,
    Key? key,
    required this.focusNodes,
    required this.fieldIndex,
    required this.onAutoFill,
    this.validator,
  }) : super(key: key);

  @override
  State<OtpField> createState() => OtpFieldState();
}

class OtpFieldState extends State<OtpField> {
  String text = "";

  bool hideInput = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Return the OTP field value
  String get value => text.replaceAll("\u200b", '');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58.w,
      width: 48.w,
      child: TextFormField(
        validator: widget.validator,
        style: context.textThemes.bodyLarge?.copyWith(color: hideInput ? Colors.transparent : null),
        autofocus: widget.fieldIndex == 0,
        enabled: hideInput ? false : true,
        focusNode: widget.focusNodes[widget.fieldIndex],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        autofillHints: const <String>[AutofillHints.oneTimeCode],
        maxLength: widget.focusNodes.length,
        cursorColor: Theme.of(context).primaryColor,
        onChanged: (newValue) {
          text = newValue;
          // SMS Auto fill
          // TODO: Find a better way to auto fill, currently for some reason using controller prevents auto fill from working in IOS
          if (newValue.length >= widget.focusNodes.length) {
            setState(() {
              hideInput = true;
            });
            widget.onAutoFill(newValue);
            return;
          }

          OTPFieldController.handleChangeFocus(
            currentText: newValue,
            context: context,
            callback: widget.callback,
            focusNodes: widget.focusNodes,
            fieldIndex: widget.fieldIndex,
          );
        },
        decoration: InputDecoration(
          helperText: "",
          helperStyle: const TextStyle(color: ColorsConst.negativeRed, fontSize: 0),
          errorStyle: const TextStyle(color: ColorsConst.negativeRed, fontSize: 0),
          border: const OutlineInputBorder(borderRadius: smallBorderRadius),
          enabledBorder: const OutlineInputBorder(
            borderRadius: smallBorderRadius,
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: smallBorderRadius, borderSide: BorderSide(width: 1.w, color: ColorsConst.negativeRed)),
          errorBorder: OutlineInputBorder(
              borderRadius: smallBorderRadius, borderSide: BorderSide(width: 1.w, color: ColorsConst.negativeRed)),
          hintStyle: context.textThemes.bodySmall?.copyWith(color: ColorsConst.lightGrey),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          isDense: true,
          fillColor: ColorsConst.cultured,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsConst.cosmicCobalt, width: 0.8.w), borderRadius: smallBorderRadius),
          counterText: '',
        ),
      ),
    );
  }
}
