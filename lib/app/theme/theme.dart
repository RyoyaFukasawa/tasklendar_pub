import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/styles/app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.white,
      onPrimary: AppColors.gray,
      secondary: AppColors.red,
      tertiary: AppColors.orange,
      error: AppColors.red,
    ),
    canvasColor: AppColors.white,
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.gray,
      onPrimary: AppColors.white,
      secondary: AppColors.red,
      tertiary: AppColors.orange,
      error: AppColors.red,
    ),
    canvasColor: AppColors.gray,
  );

  static ThemeData get theme => Get.theme;
  static ColorScheme get colorScheme => Get.theme.colorScheme;
}
