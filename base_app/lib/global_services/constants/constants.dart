import 'package:flutter/material.dart';

// Car Owner App Colors
const lightGrey = Color(0xFFB2B8CF);
const veryLightGrey = Color(0xFFD0D4E0);
const homePageContainerGrey = Color(0xFFEFF1F4);
const deleteRedColor = Color.fromRGBO(196, 15, 15, 0.88);
const contaierGreyColor = Color(0xFFF5F8FA);
const darkGrey = Color(0xFF595D6B);
const veryDarkGrey = Color(0xff051757);
const walletContainerGrey = Color(0xffF5F8FA);
const lightGrey2 = Color(0xffCACACA);
const bookingDateGrey = Color(0xffF5F8FA);
const transparentWhite = Color.fromARGB(229, 255, 255, 255);

// Service Provider Colors
class ServiceProviderColors {
  // Primary
  static const consmicCobalt100 = Color(0xff312782);
  static const consmicCobalt80 = Color(0xff5A529b);
  static const consmicCobalt60 = Color(0xff837DB4);
  static const consmicCobalt20 = Color(0xffD6D4E6);

  static const pictonBlue100 = Color(0xff35A8E0);
  static const pictonBlue80 = Color(0xff5DB9E6);
  static const pictonBlue60 = Color(0xff86CBEC);
  static const pictonBlue20 = Color(0xffAEDCF3);

  // Background
  static const whiteColor = Colors.white;
  static const clutured = Color(0xfff5f8fa);

  // Strings
  static const darkGreyString = Color(0xff1F262d);
  static const blackCoral = Color(0xff555F68);
  static const lightGreyString = Color(0xff9CA7B1);
  static const disableGrey = Color(0xffE2E7EC);

  // Status
  static const errorRed = Color(0xffEB5757);
  static const positiveGreen = Color(0xff40c97b);
  static const warningYellow = Color(0xffF2C94C);
  static const infoBlue = Color(0xff4C71F2);

  // Theme Colors
  static const themeOrangeColor = Color(0xffF29100);
  static const redThemeColor = Color(0xffE5332A);
}

// Boarder radiuses
const bottomSheetBorderRadius = BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0));
const smallBorderRadius = BorderRadius.all(Radius.circular(10));
const mediumBorderRadius = BorderRadius.all(Radius.circular(30));
const largeBorderRadius = BorderRadius.all(Radius.circular(40));

const double verySmallSeparation = 5;
const double smallSeparation = 10;
const double mediumSeparation = 15;
const double largeSeparation = 20;
const double veryLargeSeparation = 25;

// Flags
const saudiArabiaFlag = 'assets/svg/saudi_arabia_flag.svg';
const fullScreenIcon = 'assets/svg/full_screen.svg';
const exitFullScreenIcon = 'assets/svg/exit_full_screen.svg';

// Fonts
const dinNext = 'DinNext';

class ScreensSizesConstants {
  static const manageServicesScreenH = 750;
  static const manageServicesScreenW = 950;
}

class ShadowsConstants {
  static final blackShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 0.5,
    blurRadius: 10,
  );
}

class BordersConstants {
  static final whiteBorder = Border.all(color: ServiceProviderColors.whiteColor);
  static final consmicCobalt60Border = Border.all(color: ServiceProviderColors.consmicCobalt60);
}

class BorderSideConstants {
  static const consmicCobalt60BorderSide = BorderSide(color: ServiceProviderColors.consmicCobalt60, width: 0.6);
}

class BorderRadiusConstants {
  static const circularBorderRadius = BorderRadius.all(Radius.circular(100));
}

class GlobalAssetsConstants {
  static const garageLogo = "assets/svg/garage_lines.svg";
}
