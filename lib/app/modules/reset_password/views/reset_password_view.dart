import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/components/custom_dialog/custom_dialog.dart';
import 'package:tasklendar/app/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:tasklendar/app/components/custom_text_field/custom_test_field.dart';
import 'package:tasklendar/app/routes/app_pages.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/validation.dart';
import 'package:tasklendar/generated/locales.g.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            // controller.errors.clear();
          },
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: AppTheme.colorScheme.onPrimary,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Get.width * 0.8,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.2,
                child: Image.asset('assets/images/logo.png'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: controller.formKey.value,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.emailController,
                          labelText: 'email',
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
                                    controller.errors['email'],
                                    style: AppTypography.formError,
                                  ),
                                )
                              : Container();
                        }),
                        Gap(40),
                        CustomElevatedButton(
                          text: LocaleKeys.send_reset_password_email.tr,
                          onPressed: () {
                            controller.errors.clear();
                            controller.formKey.value.currentState!.validate();
                            if (controller.errors.values
                                .every((value) => value == null)) {
                              controller.sendPasswordResetEmail(
                                controller.emailController.text.trim(),
                                () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CustomDialog(
                                        title: 'Success',
                                        content:
                                            'Please check your email to reset your password.',
                                        onPressed: () {
                                          controller.errors.clear();
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
