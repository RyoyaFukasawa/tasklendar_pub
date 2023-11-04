// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/gen/fonts.gen.dart';
import 'package:tasklendar/config/styles/app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.orange,
      onPrimary: AppColors.white,
      secondary: AppColors.red,
      onSecondary: AppColors.white,
      tertiary: AppColors.blue,
      onTertiary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      background: AppColors.white,
      onBackground: AppColors.black,
    ),
    canvasColor: AppColors.white,
    cardColor: AppColors.darkWhite,
    // fontFamily: FontFamily.notoSansJP,
    // fontFamily: FontFamily.zenKakuGothicNew,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
    ),
    splashColor: transparent,
    hoverColor: transparent,
    focusColor: transparent,
    highlightColor: transparent,
    dividerColor: transparent,
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // 塗りつぶし
      fillColor: AppColors.darkWhite,
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: MaterialStateProperty.all(
          AppColors.white,
        ),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.orange,
      onPrimary: AppColors.white,
      secondary: AppColors.red,
      onSecondary: AppColors.white,
      tertiary: AppColors.blue,
      onTertiary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      background: AppColors.black,
      onBackground: AppColors.darkWhite,
    ),
    canvasColor: AppColors.white,
    cardColor: AppColors.darkWhite,
    fontFamily: FontFamily.notoSansJP,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
    ),
    splashColor: transparent,
    hoverColor: transparent,
    focusColor: transparent,
    highlightColor: transparent,
    dividerColor: transparent,
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // 塗りつぶし
      fillColor: AppColors.darkWhite,
    ),
  );

  static ColorScheme get colorScheme => Theme.of(useContext()).colorScheme;
}
