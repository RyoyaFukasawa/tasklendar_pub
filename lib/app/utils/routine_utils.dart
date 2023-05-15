import 'package:get/get.dart';
import 'package:tasklendar/generated/locales.g.dart';

class RoutineUtils {
  static const MONDAY = 0;
  static const TUESDAY = 1;
  static const WEDNESDAY = 2;
  static const THURSDAY = 3;
  static const FRIDAY = 4;
  static const SATURDAY = 5;
  static const SUNDAY = 6;

  static List period = [
    LocaleKeys.period_daily.tr,
    LocaleKeys.period_every_other_day.tr,
    LocaleKeys.period_weekly.tr,
    LocaleKeys.period_biweekly.tr,
    LocaleKeys.period_monthly.tr,
  ];

  static List dateType = [
    LocaleKeys.date_type_start_date.tr,
    LocaleKeys.date_type_end_date.tr,
  ];

  static Map dayOfWeek = {
    LocaleKeys.day_of_week_monday.tr: MONDAY,
    LocaleKeys.day_of_week_tuesday.tr: TUESDAY,
    LocaleKeys.day_of_week_wednesday.tr: WEDNESDAY,
    LocaleKeys.day_of_week_thursday.tr: THURSDAY,
    LocaleKeys.day_of_week_friday.tr: FRIDAY,
    LocaleKeys.day_of_week_saturday.tr: SATURDAY,
    LocaleKeys.day_of_week_sunday.tr: SUNDAY,
  };

  static List days = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
  ];
}
