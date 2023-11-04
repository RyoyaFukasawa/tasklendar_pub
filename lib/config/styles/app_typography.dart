// Dart imports:
import 'dart:ffi';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';

class AppTypography {
  static const double defaultFontSize = 12.0;
  static const FontWeight defaultFontWeight = FontWeight.w600;

  static TextStyle h1 = const TextStyle(
    fontSize: defaultFontSize * 2.5,
    fontWeight: FontWeight.w700,
  );

  static TextStyle h2 = const TextStyle(
    fontSize: defaultFontSize * 2.0,
    fontWeight: defaultFontWeight,
  );

  static TextStyle h3 = const TextStyle(
    fontSize: defaultFontSize * 1.75,
    fontWeight: defaultFontWeight,
  );

  static TextStyle h4 = const TextStyle(
    fontSize: defaultFontSize * 1.5,
    fontWeight: defaultFontWeight,
  );

  static TextStyle h5 = const TextStyle(
    fontSize: defaultFontSize * 1.25,
    fontWeight: defaultFontWeight,
  );

  static TextStyle error = TextStyle(
    fontSize: defaultFontSize,
    fontWeight: defaultFontWeight,
    color: AppColors.red,
  );

  static TextStyle body = const TextStyle(
    fontSize: defaultFontSize,
    fontWeight: defaultFontWeight,
  );

  static TextStyle calendarTodo = const TextStyle(
    fontSize: defaultFontSize * 0.8,
    fontWeight: defaultFontWeight,
  );

  static TextStyle todo = const TextStyle(
    fontSize: defaultFontSize,
    fontWeight: FontWeight.bold,
    fontFamily: 'EbiharaNoKuseji',
  );
}
