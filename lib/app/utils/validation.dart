import 'package:get/utils.dart';
import 'package:tasklendar/generated/locales.g.dart';

class Validators {
  static String? validateTask(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.error_empty_task.tr;
    }
    return null;
  }

  static String? validateRoutine(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.error_empty_routine.tr;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.error_empty_email.tr;
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return LocaleKeys.error_invalid_email.tr;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.error_empty_password.tr;
    }
    // 8 or more characters, including English and numbers
    String pattern = r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9]{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return LocaleKeys.error_invalid_password.tr;
    }
    return null;
  }
}
