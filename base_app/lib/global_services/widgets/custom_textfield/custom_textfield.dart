import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:garage_client/global_services/services/validator.dart';
import 'package:garage_client/global_services/widgets/custom_textfield/controller.dart';
import 'package:garage_client/global_services/widgets/custom_textfield/textfield_types.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.type,
    this.textFieldStyle =
        const TextStyle(color: ServiceProviderColors.darkGreyString, fontFamily: dinNext, fontWeight: FontWeight.w200),
    required this.controller,
    this.onChange,
    this.onSubmit,
    this.placeHolderText,
    this.isPassword = false,
    this.icon,
    this.width = 50,
    this.validator,
    this.label = '',
    this.indicateValid = false,
    this.showIconLeading = false,
    this.height = 4,
    this.isEnabled = true,
    this.hasCounter = false,
    this.counterText = "",
    this.initialValue,
    this.applyLanguageRestriction = false,
    this.textLanguage = "en",
  }) : super(key: key);

  final bool indicateValid;
  final TextFieldType type;
  final TextEditingController controller;
  final String? placeHolderText;
  final void Function(String?)? onSubmit;
  final void Function(String?)? onChange;

  /// A function that will return an error [String] or [null] when there is no error
  final String? Function(String)? validator;
  final double width;
  final double height;
  final IconData? icon;
  final bool isPassword;
  final String label;
  final bool showIconLeading;
  final bool isEnabled;
  final bool hasCounter;
  final String counterText;
  final String? initialValue;

  final TextStyle textFieldStyle;
  final bool applyLanguageRestriction;
  final String textLanguage;

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextFieldType type;

  final FocusNode _focusNode = FocusNode();
  String? errorMessage;
  bool showValid = false;
  final CustomTextFieldWidgetController _widgetController = CustomTextFieldWidgetController();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          type = TextFieldType.active;
        });
      } else {
        _handleValidation();
        setState(() {
          type = TextFieldType.normal;
        });
      }
    });
    type = widget.type;
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }
    super.initState();
  }

  bool get isValid => errorMessage == null;

  void _handleValidation() {
    if (widget.validator is Function) {
      setState(() {
        errorMessage = widget.validator!(widget.controller.text);
        showValid = widget.indicateValid && widget.controller.text.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != ''
            ? Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: widget.label != '' ? 6 : 0,
        ),
        Directionality(
          textDirection: widget.textLanguage == "ar" ? TextDirection.rtl : TextDirection.ltr,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
              boxShadow: type == TextFieldType.active
                  ? [
                      BoxShadow(
                          color: ServiceProviderColors.consmicCobalt100.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 1)
                    ]
                  : null,
              color: ServiceProviderColors.whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: ServiceProviderColors.consmicCobalt60),
            ),
            width: widget.width,
            child: Row(
              children: [
                widget.showIconLeading
                    ? Icon(
                        widget.icon,
                        color: _widgetController.getTextFieldColor(type, isValid, showValid),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  width: widget.width - (widget.icon != null ? 100 : 70),
                  height: widget.height,
                  child: TextField(
                    inputFormatters: widget.applyLanguageRestriction
                        ? [
                            FilteringTextInputFormatter.allow(
                                RegExp(Validator.languageStringValidator(widget.textLanguage)))
                          ]
                        : null,
                    enabled: widget.isEnabled,
                    obscureText: widget.isPassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                        color: ServiceProviderColors.darkGreyString, fontFamily: dinNext, fontWeight: FontWeight.w200),
                    focusNode: _focusNode,
                    controller: widget.controller,
                    onChanged: widget.onChange,
                    onSubmitted: widget.onSubmit,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.placeHolderText,
                    ),
                    buildCounter: widget.hasCounter
                        ? (_, {required currentLength, maxLength, required isFocused}) => Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: widget.height - 5,
                                  left: widget.textLanguage == "ar" ? -15 : widget.width - 110,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${widget.counterText} " + (maxLength! - currentLength).toString(),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: ServiceProviderColors.lightGreyString,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      )),
                                ),
                              ],
                            )
                        : null,
                    maxLines: widget.hasCounter ? 5 : 1,
                    minLines: widget.hasCounter ? 5 : 1,
                    maxLength: widget.hasCounter ? 400 : null,
                  ),
                ),
                const Spacer(),
                !widget.showIconLeading
                    ? Icon(
                        widget.icon,
                        color: _widgetController.getTextFieldColor(type, isValid, showValid),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        errorMessage != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  errorMessage ?? '',
                  style: const TextStyle(color: ServiceProviderColors.errorRed, fontSize: 15, fontFamily: dinNext),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
