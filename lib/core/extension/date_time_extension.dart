// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';

extension DateTimeExtension on DateTime {
  DateTime truncateTime() {
    return DateTime(year, month, day);
  }

  String monthFormat() {
    if (year == now.year) {
      return DateFormat.MMMM(
        PlatformDispatcher.instance.locale.languageCode,
      ).format(this).toString();
    }
    return DateFormat.yMMMM(PlatformDispatcher.instance.locale.languageCode)
        .format(this)
        .toString();
  }

  DateTime firstDayOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime lastDayOfMonth() {
    return DateTime(year, month + 1, 0);
  }

  DateTime lastDayOfLastMonth() {
    return DateTime(year, month, 0);
  }

  String yMMMEd() {
    return DateFormat.yMMMEd(PlatformDispatcher.instance.locale.languageCode)
        .format(this)
        .toString();
  }

  String yMMMd() {
    if (year == now.year) {
      return DateFormat.MMMd(
        PlatformDispatcher.instance.locale.languageCode,
      ).format(this).toString();
    }
    return DateFormat.yMMMd(PlatformDispatcher.instance.locale.languageCode)
        .format(this)
        .toString();
  }

  String mMMEd() {
    return DateFormat.MMMEd(PlatformDispatcher.instance.locale.languageCode)
        .format(this)
        .toString();
  }

  String d() {
    return DateFormat.d(PlatformDispatcher.instance.locale.languageCode)
        .format(this)
        .toString();
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}
