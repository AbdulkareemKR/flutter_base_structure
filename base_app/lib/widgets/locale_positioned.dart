import 'package:flutter/material.dart';
import 'package:garage_client/app.dart';

class LocalePositioned extends StatelessWidget {
  const LocalePositioned(
      {Key? key, required this.localeSide, this.top, this.bottom, this.flip = false, required this.child})
      : super(key: key);

  /// You can control it by passing [flip] to change it.
  /// will be from right if [lang] is [ar] and left if [en]
  final double localeSide;

  /// Normal positioned parameters
  final double? top;
  final double? bottom;
  final Widget child;

  /// will make left for [ar] and right for [en]
  final bool flip;

  ///
  /// You can use [!_isRight();] :)
  bool _isLeft() {
    return !_isRight();
  }

  /// Determine the correct direction base on the lang code
  bool _isRight() {
    /// Check that the language is [ar] and no flip
    if ((App.lang == 'ar' && !flip) || (App.lang == 'en' && flip)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: child,
      right: _isRight() ? localeSide : null,
      left: _isLeft() ? localeSide : null,
      top: top,
      bottom: bottom,
    );
  }
}
