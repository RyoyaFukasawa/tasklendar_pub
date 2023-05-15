import 'package:get/get.dart';
import 'package:tasklendar/generated/locales.g.dart';

class CalendarUtils {
  static const int JANUARY = 1;
  static const int FEBRUARY = 2;
  static const int MARCH = 3;
  static const int APRIL = 4;
  static const int MAY = 5;
  static const int JUNE = 6;
  static const int JULY = 7;
  static const int AUGUST = 8;
  static const int SEPTEMBER = 9;
  static const int OCTOBER = 10;
  static const int NOVEMBER = 11;
  static const int DECEMBER = 12;

  static Map<int, String> months = {
    1: LocaleKeys.month_january.tr,
    2: LocaleKeys.month_february.tr,
    3: LocaleKeys.month_march.tr,
    4: LocaleKeys.month_april.tr,
    5: LocaleKeys.month_may.tr,
    6: LocaleKeys.month_june.tr,
    7: LocaleKeys.month_july.tr,
    8: LocaleKeys.month_august.tr,
    9: LocaleKeys.month_september.tr,
    10: LocaleKeys.month_october.tr,
    11: LocaleKeys.month_november.tr,
    12: LocaleKeys.month_december.tr,
  };

  static List<String> dayOfWeek = [
    LocaleKeys.day_of_week_monday.tr,
    LocaleKeys.day_of_week_tuesday.tr,
    LocaleKeys.day_of_week_wednesday.tr,
    LocaleKeys.day_of_week_thursday.tr,
    LocaleKeys.day_of_week_friday.tr,
    LocaleKeys.day_of_week_saturday.tr,
    LocaleKeys.day_of_week_sunday.tr,
  ];
}
