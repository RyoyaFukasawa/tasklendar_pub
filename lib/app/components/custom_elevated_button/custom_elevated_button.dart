import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
  });

  final bool isLoading;
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.6,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: AppTheme.colorScheme.onPrimary,
            width: 2,
          ),
          backgroundColor: backgroundColor ?? AppTheme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(300),
          ),
          padding: const EdgeInsets.all(0),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: AppTypography.getPreferredFont(),
            color: textColor ?? AppTheme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
