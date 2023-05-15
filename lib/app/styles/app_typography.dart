import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/theme/theme.dart';

class AppTypography {
  static String getPreferredFont() {
    return Get.deviceLocale?.languageCode == 'en'
        ? 'FredokaOne'
        : 'MochiyPopOne';
  }

  static TextStyle title = TextStyle(
    color: AppTheme.colorScheme.onPrimary,
    fontSize: 36,
    fontFamily: getPreferredFont(),
  );

  static TextStyle h1 = TextStyle(
    color: AppTheme.colorScheme.onPrimary,
    fontSize: 30,
    fontFamily: getPreferredFont(),
  );

  static TextStyle h2 = TextStyle(
    color: AppTheme.colorScheme.onPrimary,
    fontSize: 25,
    fontFamily: getPreferredFont(),
  );

  static TextStyle h3 = TextStyle(
    color: AppTheme.colorScheme.onPrimary,
    fontSize: 20,
    fontFamily: getPreferredFont(),
  );

  static TextStyle h4 = TextStyle(
    color: AppTheme.colorScheme.onPrimary,
    fontSize: 18,
    fontFamily: getPreferredFont(),
  );

  static TextStyle h5 = TextStyle(
    color: AppTheme.colorScheme.onPrimary,
    fontSize: 15,
    fontFamily: getPreferredFont(),
  );

  static TextStyle formError = TextStyle(
    color: AppTheme.colorScheme.error,
    fontSize: 15,
    fontFamily: getPreferredFont(),
  );

  static TextStyle dismissibleText = TextStyle(
    color: AppTheme.colorScheme.primary,
    fontSize: 20,
    fontFamily: getPreferredFont(),
  );

  static TextStyle todo({
    required bool lineThrough,
    required bool fontWeight,
  }) =>
      TextStyle(
        color: AppTheme.colorScheme.onPrimary,
        fontSize: 24,
        fontFamily: 'EbiharaNoKuseji',
        decoration: lineThrough ? TextDecoration.lineThrough : null,
        fontWeight: fontWeight ? FontWeight.bold : FontWeight.normal,
      );
}
