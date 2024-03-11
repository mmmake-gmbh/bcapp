import 'package:flutter/material.dart';

class AppColors {
  static const Map<int, Color> primaryOneColorMap = {
    50: Color.fromRGBO(25, 62, 105, .1),
    100: Color.fromRGBO(25, 62, 105, .2),
    200: Color.fromRGBO(25, 62, 105, .3),
    300: Color.fromRGBO(25, 62, 105, .4),
    400: Color.fromRGBO(25, 62, 105, .5),
    500: Color.fromRGBO(25, 62, 105, .6),
    600: Color.fromRGBO(25, 62, 105, .7),
    700: Color.fromRGBO(25, 62, 105, .8),
    800: Color.fromRGBO(25, 62, 105, .9),
    900: Color.fromRGBO(25, 62, 105, 1),
  };
  static const MaterialColor primaryOneMaterialColor =
      MaterialColor(0xFF193E69, primaryOneColorMap);
  static const Color primaryOneColor = Color.fromARGB(255, 25, 62, 105);
  static const Color primaryOneLightColor = Color.fromARGB(255, 75, 104, 151);
  static const Color primaryTwoColor = Color.fromARGB(255, 43, 120, 167);
  static const Color primaryTwoLightColor = Color.fromARGB(255, 96, 169, 214);
  static const Color secondaryOneColor = Color.fromARGB(255, 255, 240, 65);
  static const Color secondaryOneLightColor =
      Color.fromARGB(255, 255, 255, 119);
  static const Color secondaryTwoColor = Color.fromARGB(255, 17, 193, 176);
  static const Color secondaryTwoLightColor =
      Color.fromARGB(255, 200, 255, 244);
  static const Color primaryOneTextColor = Colors.white;

  static const Color mainTextColor = Color.fromARGB(255, 77, 77, 77);

  static const Color settingBgColor = Color.fromARGB(255, 244, 247, 249);
  static const Color settingListTileTitleColor =
      Color.fromARGB(255, 28, 27, 31);
  static const Color settingListTileSeparatorColor =
      Color.fromARGB(255, 202, 196, 208);

  static const campusCardTileBgColor = Color.fromARGB(255, 5, 162, 155);
  static const campusTileBgColor = Color.fromARGB(255, 226, 233, 242);
  static const parkingTileBgColor = Color.fromARGB(255, 143, 170, 197);
  static const timetableTileBgColor = parkingTileBgColor;
  static const welcomeTileTextBgColor = Color.fromARGB(255, 27, 61, 106);
  static const fourtyTwoTileTextBgColor = campusCardTileBgColor;

  static const newFlagBgColor = parkingTileBgColor;
  static const newFlagButtonBgColor = welcomeTileTextBgColor;

  static const parkingCardSubtitleColor = Color.fromRGBO(0, 0, 0, 0.54);
  static const parkingViewBackgroundColor = Color.fromARGB(255, 245, 248, 250);
  static const parkingViewEmptyPriceBgColor =
      Color.fromARGB(255, 232, 244, 253);
  static const parkingViewEmptyPriceTextColor = Color.fromARGB(255, 13, 60, 97);
  static const parkingViewBorderColor = Color.fromRGBO(226, 233, 242, 1);
  static const parkingViewIconsColor = Color.fromRGBO(115, 115, 115, 1);
  static const parkingViewIconsBgColor = Color.fromRGBO(250, 250, 250, 1);
  static const parkingViewIconsTextColor = Color.fromRGBO(0, 200, 83, 1);
  static const parkingViewIconsSeparatorColor =
      Color.fromRGBO(27, 61, 106, 0.05);

  static const initialIndicatorColor = Color.fromARGB(255, 216, 216, 216);
  static const initialIndicatorActiveColor = Color.fromARGB(255, 254, 240, 63);

  static const checkBoxBgColor = Color.fromARGB(255, 225, 225, 225);
  static const disabledButtonBgColor = checkBoxBgColor;
  static const disabledButtonTextColor = Color.fromARGB(255, 158, 158, 158);

  static const homeAppBarColor = Color.fromARGB(255, 73, 69, 79);

  static const mensaBgColor = Color(0xFF2B78A7);
}
