import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom button to be used across the apps
class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String? text;
  final Widget? child;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final String? fontFamily;

  const CustomButton({
    Key? key,
    this.fontFamily,
    this.fontSize = 20,
    this.height = 100,
    this.textColor = Colors.white,
    this.borderColor = Colors.black,
    this.child,
    this.width = 200,
    this.text,
    this.onPressed,
    this.backgroundColor = Colors.black,
  })  : // The user should provide a String text or a child
        assert((child == null || text == null) && (child != null || text != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(width: 2.sp, color: borderColor),
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Center(
            child: child ??
                Text(
                  text!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontFamily: fontFamily, fontSize: fontSize, color: textColor),
                ),
          ),
        ));
  }
}
