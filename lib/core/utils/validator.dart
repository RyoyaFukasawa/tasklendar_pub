// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:tasklendar/core/extension/string_extension.dart';

class Validator {
  // static String? validateTask(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return LocaleKeys.error_empty_task.tr;
  //   }
  //   return null;
  // }

  // static String? validateRoutine(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return LocaleKeys.error_empty_routine.tr;
  //   }
  //   return null;
  // }

  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.error_empty_email;
    }
    bool res = value.isValidEmail();
    if (!res) {
      return AppLocalizations.of(context)!.error_invalid_email;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.error_empty_password;
    }

    bool res = value.isValidPassword();
    if (!res) {
      return AppLocalizations.of(context)!.error_invalid_password;
    }
    return null;
  }

  static String? validateEmoji(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.error_empty_emoji;
    }
    bool res = value.isValidEmoji();
    if (!res) {
      return AppLocalizations.of(context)!.error_invalid_emoji;
    }
    return null;
  }

  static String? validateGroupName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.error_empty_group_name;
    }
    bool res = value.isValidGroupName();
    if (!res) {
      return AppLocalizations.of(context)!.error_invalid_group_name;
    }
    return null;
  }

  // static String? validateEndDate(DateTime? enDate, bool isInfinite) {
  //   if (enDate == null && !isInfinite) {
  //     return LocaleKeys.error_end_date_required.tr;
  //   }
  //   return null;
  // }

  // static String? validateInterval(int? value) {
  //   if (value == 0) {
  //     return LocaleKeys.error_empty_interval.tr;
  //   }
  //   return null;
  // }
}
