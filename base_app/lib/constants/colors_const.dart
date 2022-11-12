import 'package:flutter/material.dart';

///
/// This class should contains all the colors that will be used
/// in the app. If the colors is not here, add it.
class ColorsConst {
  static const MaterialColor cosmicCobalt = MaterialColor(
    _cosmicCobaltValue,
    <int, Color>{
      /// cosmicCobalt20
      100: Color(0xffD6D4E6),

      200: Color(0xff837DB4),

      /// cosmicCobalt60
      300: Color(0xff837DB4),

      /// cosmicCobalt80
      400: Color(0xff5A529B),

      /// cosmicCobalt100
      500: Color(_cosmicCobaltValue),
    },
  );
  static const int _cosmicCobaltValue = 0xff312782;

  static const MaterialColor pictonBlue = MaterialColor(
    _pictonBlueValue,
    <int, Color>{
      /// pictonBlue20
      100: Color(0xffAEDCF3),

      /// pictonBlue60
      300: Color(0xff86CBEC),

      /// pictonBlue80
      400: Color(0xff5DB9E6),

      /// pictonBlue100
      500: Color(_pictonBlueValue),
    },
  );
  static const int _pictonBlueValue = 0xff35A8E0;

  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static const cultured = Color(0xffFAFAFA);

  static const profilePictureGrey = Color(0xffF6F6F6);
  static const dartGrey = Color(0xff1F262D);
  static const blackCoral = Color(0xff555F68);
  static const lightGrey = Color(0xff9CA7B1);
  static const disableGrey = Color(0xffE2E7EC);
  static const gunmetalLight = Color(0xff656565);

  static const negativeRed = Color(0xffEB5757);
  static const positiveGreen = Color(0xff40c97b);
  static const warningYellow = Color(0xffF2C94C);
  static const infoBlue = Color(0xff4C71F2);
}
