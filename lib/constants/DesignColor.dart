import 'dart:math';

import 'package:flutter/material.dart';

const transperent = Colors.transparent;
const bool isDarkTheme = false;

class DesignColor {
  static const primary = Color(0xffD30E18);
  static const primaryLight1 = Color.fromARGB(255, 248, 214, 223);
  static const primaryFaint = Color(0xffF2A9BC);
  static const primaryDark = Color.fromARGB(255, 226, 42, 42);
  static const primaryShade2 = Color(0xff8C70A6);

  static Color secondary = const Color(0xffFF0000);
  static Color tertiary = const Color(0xffFFCD00); 
  static Color tertiary2 = const Color(0xffFFB600);
  
  static const transparent = Colors.transparent;

  static const primaryGrey = Color(0xff798BA7);
  static const primaryGrey400 = Color(0xffB3BECD);

  static const light = Colors.white;
  static const dark = Color(0xff030303);

  static const darkGrey = Color(0xff222020);
  static const lightBlack = Color(0xff262626);
  static final grey1 = Color(0xff1C1C1C).withAlpha(175);

  static const lightGrey = Color(0xffD9D9D9);
  static final lightGrey30 = Color(0xffDFE0E2).withAlpha(100);
  static const lightGrey2 = Color(0xffEAEAEA);

  static const lightGrey1 = Color(0xffD8D5EA);
  static Color hint = Colors.grey;
  static Color bg = Color(0xffE8E9EB);
  static Color appbarBg = Color(0xffFF0000);
  //  Color(0xFFFFB805);
  static Color themeBlue = Color(0xFF244C8F);

  static Color borderColor = Color(0xFF999999);

  static Color tabGrey = Color(0xFF606060);

  static Color green = Color(0xFF1F8435);
  static Color greenDark = Color(0xFF32BA7C);
  static Color greenShade1 = Color(0xFF4BDD9B);

  static Color red = Color(0xFFfFF0000);

  static Color purple = Color.fromARGB(255, 231, 114, 235);

  static Color yellow = Colors.yellow;
  static Color veryLightYellow = Color(0xFFFFF3D6);

  static Color grey = Color(0xff454545);
  static Color midGrey = Colors.grey.shade400;
  static Color lightGreen = Color(0xFF67EB00);
  static Color lightRed = Color(0xFFE37B7B);
  static Color plusminusButton = Color(0xFFFFB36E);
  static Color minusGrey = Color(0xFF555555);

  static List<Color> gradientcolor = [
    DesignColor.mainGreen,
    DesignColor.white,
  ];

  static List<Color> gridItemColors = [
    Color(0xffEB61D9),
    Color(0xff6BE7C2),
    Color(0xff8156F7),
    Color(0xffFDBC63),
  ];

  // ignore: use_full_hex_values_for_flutter_colors
  static Color extraLightGrey = const Color(0xffE1E8ED);
  static Color extraExtraLightGrey = const Color(0xffD4D4D5);
  static Color white = Colors.white;
  static Color black = Colors.black;

  static Color black50 = Colors.black.withAlpha((50 * 2.55).toInt());

  static Color black30 = Colors.black.withAlpha((30 * 2.55).toInt());
  static Color mainGreen = const Color(0xff1B4046);

  /// as per figma design
  static Color contentTextSecondary = const Color(0xff949494);
  static Color contentTextSecondary1 = const Color(0xff6E6E6E);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.5),
    100: tintColor(color, 0.4),
    200: tintColor(color, 0.3),
    300: tintColor(color, 0.2),
    400: tintColor(color, 0.1),
    500: tintColor(color, 0),
    600: tintColor(color, -0.1),
    700: tintColor(color, -0.2),
    800: tintColor(color, -0.3),
    900: tintColor(color, -0.4),
  });
}

int tintValue(int value, double factor) {
  return max(0, min((value + ((255 - value) * factor)).round(), 255));
}

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);
