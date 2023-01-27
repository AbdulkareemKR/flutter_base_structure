import 'package:flutter/material.dart';
import 'package:garage_client/constants/border_radius_const.dart';
import 'package:garage_client/constants/constants.dart';

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
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.only(bottom: 2),
      height: 6,
      width: width,
      decoration:  BoxDecoration(color: Colors.white, borderRadius:  BorderRadiusConst.largeBorderRadius),
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
