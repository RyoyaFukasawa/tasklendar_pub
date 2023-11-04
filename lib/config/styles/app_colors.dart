// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  static Color white = Colors.white;
  static Color black = const Color(0xFF333333);
  static Color orange = const Color(0xFFF28B50);
  static Color red = const Color(0xFFEB534F);
  static Color wineRed = const Color(0xFFD43D77);
  static Color green = const Color(0xFF38B372);
  static Color rightBlue = const Color(0xFF32BBBF);
  static Color blue = const Color(0xFF49A2EB);
  static Color darkBlue = const Color(0xFF39719E);
  static Color purple = const Color(0xFFA960EB);
  static Color pink = const Color(0xFFEB6CD8);
  static Color darkPink = const Color(0xFF9E398F);
  static Color darkWhite = const Color(0xFFEDEDED);
  static Color placeholder = const Color(0xFFC4C4C4);

  static LinearGradient gradient = LinearGradient(
    colors: [
      orange,
      red,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<Color> colorList = [
    orange,
    red,
    wineRed,
    green,
    rightBlue,
    blue,
    darkBlue,
    purple,
    pink,
    darkPink,
  ];
}
