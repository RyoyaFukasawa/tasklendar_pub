import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:tasklendar/app/components/custom_text_field/custom_test_field.dart';
import 'package:tasklendar/app/routes/app_pages.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/validation.dart';
import 'package:tasklendar/generated/locales.g.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.errors.clear();
          },
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: AppTheme.colorScheme.onPrimary,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: Get.width * 0.8,
          alignment: Alignment.center,
          child: Form(
            key: controller.formKey,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.sign_up.tr,
                    style: AppTypography.h1,
                  ),
                  Gap(30),
                  CustomTextFormField(
                    autofocus: true,
                    controller: controller.emailController,
                    labelText: LocaleKeys.email.tr,
                    validator: (value) {
                      controller.errors['email'] =
                          Validators.validateEmail(value);
                      return null;
                    },
                  ),
                  Obx(() {
                    return controller.errors['email'] != null
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.errors['email']!,
                              style: AppTypography.formError,
                            ),
                          )
                        : Container();
                  }),
                  Gap(10),
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.passwordController,
                      labelText: LocaleKeys.password.tr,
                      obscureText: controller.isObscure.value,
                      validator: (value) {
                        controller.errors['password'] =
                            Validators.validatePassword(value);
                        return null;
                      },
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 30,
                            child: IconButton(
                              onPressed: () {
                                controller.isObscure.value =
                                    !controller.isObscure.value;
                              },
                              icon: Obx(() {
                                return Icon(
                                  controller.isObscure.value
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  color: AppTheme.colorScheme.onPrimary,
                                  size: 18,
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    return controller.errors['password'] != null
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.errors['password']!,
                              style: AppTypography.formError,
                            ),
                          )
                        : Container();
                  }),
                  Gap(20),
                  CustomElevatedButton(
                    text: LocaleKeys.sign_up.tr,
                    backgroundColor: AppTheme.colorScheme.primary,
                    textColor: AppTheme.colorScheme.onPrimary,
                    onPressed: () {
                      controller.formKey.currentState!.validate();
                      if (controller.errors.values
                          .every((value) => value == null)) {
                        controller.signUp(
                          controller.emailController.text.trim(),
                          controller.passwordController.text.trim(),
                          () {
                            Get.toNamed(Routes.TODO);
                          },
                        );
                      }
                    },
                  ),
                  Gap(10),
                  Text(
                    LocaleKeys.or.tr,
                    style: AppTypography.h5,
                  ),
                  Gap(10),
                  CustomElevatedButton(
                    text: LocaleKeys.sign_up_google.tr,
                    backgroundColor: AppTheme.colorScheme.secondary,
                    textColor: AppColors.white,
                    onPressed: () {
                      controller.signUpWithGoogle(
                        () {
                          Get.toNamed(Routes.TODO);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: AppBar().preferredSize.height,
      ),
    );
  }
}
