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

  static const Color weatherTileBgColor = Color.fromARGB(255, 234, 242, 246);
  static const Color weatherTileTextColor = Color.fromARGB(255, 59, 59, 59);
  static const Color weatherIconColor = settingListTileTitleColor;
  static const Color campusCardTileBgColor = Color.fromARGB(255, 5, 162, 155);
  static const Color campusTileBgColor = Color.fromARGB(255, 226, 233, 242);
  static const Color campusTileTitleColor = Color.fromARGB(255, 226, 233, 242);
  static const Color campusTileContentColor = mainTextColor;
  static const Color parkingTileBgColor = Color.fromARGB(255, 143, 170, 197);
  static const Color timetableTileBgColor = parkingTileBgColor;
  static const Color welcomeTileTextBgColor = Color.fromARGB(255, 27, 61, 106);
  static const Color fourtyTwoTileTextBgColor = campusCardTileBgColor;

  static const Color drawerMenuTileUnderlineColor = parkingTileBgColor;

  static const Color newFlagBgColor = parkingTileBgColor;
  static const Color newFlagButtonBgColor = welcomeTileTextBgColor;

  static const Color parkingCardSubtitleColor = Color.fromRGBO(0, 0, 0, 0.54);
  static const Color parkingCardOpeningHoursColor =
      Color.fromRGBO(0, 0, 0, 0.87);
  static const Color parkingViewBackgroundColor =
      Color.fromARGB(255, 245, 248, 250);
  static const Color parkingViewEmptyPriceBgColor =
      Color.fromARGB(255, 232, 244, 253);
  static const Color parkingViewEmptyPriceTextColor =
      Color.fromARGB(255, 13, 60, 97);
  static const Color parkingViewDisabledButtonColor =
      Color.fromARGB(255, 224, 224, 224);
  static const Color parkingViewBorderColor = Color.fromRGBO(226, 233, 242, 1);
  static const Color parkingViewIconsColor = Color.fromRGBO(115, 115, 115, 1);
  static const Color parkingViewIconsBgColor = Color.fromRGBO(250, 250, 250, 1);
  static const Color parkingViewIconsTextColor = Color.fromRGBO(0, 200, 83, 1);
  static const Color parkingViewIconsSeparatorColor =
      Color.fromRGBO(27, 61, 106, 0.05);

  static const Color parkingLightGreen = Color.fromRGBO(76, 175, 80, 1);
  static const Color parkingLightYellow = Color.fromRGBO(255, 204, 0, 1);
  static const Color parkingLightRed = Color.fromRGBO(211, 47, 47, 1);

  static const Color initialIndicatorColor = Color.fromARGB(255, 216, 216, 216);
  static const Color initialIndicatorActiveColor =
      Color.fromARGB(255, 254, 240, 63);

  static const Color checkBoxBgColor = Color.fromARGB(255, 225, 225, 225);
  static const Color disabledButtonBgColor = checkBoxBgColor;
  static const Color disabledButtonTextColor =
      Color.fromARGB(255, 158, 158, 158);

  static const Color homeAppBarColor = Color.fromARGB(255, 73, 69, 79);
}
