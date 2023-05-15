import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:tasklendar/app/routes/app_pages.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/generated/locales.g.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.7,
                child: Image.asset('assets/images/icon.png'),
              ),
              Container(
                width: Get.width * 0.8,
                child: Image.asset('assets/images/logo.png'),
              ),
              Gap(70),
              CustomElevatedButton(
                  text: LocaleKeys.login.tr,
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  }),
              Gap(30),
              CustomElevatedButton(
                text: LocaleKeys.sign_up.tr,
                backgroundColor: AppTheme.colorScheme.primary,
                textColor: AppTheme.colorScheme.onPrimary,
                onPressed: () {
                  Get.toNamed(Routes.SIGN_UP);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
