import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.onPressed,
  });

  final Function()? onPressed;
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        Center(
          child: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              color: AppTheme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: 20,
                    fontFamily: AppTypography.getPreferredFont(),
                  ),
                ),
                Gap(20),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: AppTypography.h5,
                ),
                Gap(25),
                CustomElevatedButton(
                  text: 'OK',
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
