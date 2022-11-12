import 'package:flutter/material.dart';
import 'package:garage_client/global_services/constants/constants.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, this.controller, this.hintText, this.onTap, this.onSubmit, this.width = 85})
      : super(key: key);

  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String?)? onSubmit;
  final String? hintText;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.sp),
      margin: EdgeInsets.only(bottom: 2.h),
      height: 6.h,
      width: width.w,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: largeBorderRadius),
      child: TextField(
        autocorrect: false,
        controller: controller,
        onTap: onTap,
        onSubmitted: onSubmit,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
