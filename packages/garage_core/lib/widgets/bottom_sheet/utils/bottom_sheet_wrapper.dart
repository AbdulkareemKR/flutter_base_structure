import 'package:flutter/material.dart';

class BottomSheetWrapper extends StatelessWidget {
  const BottomSheetWrapper({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: body,
    );
  }
}
