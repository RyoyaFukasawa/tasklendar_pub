import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/routine_repository.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/routine_utils.dart';
import 'package:tasklendar/generated/locales.g.dart';

class RoutineController extends GetxController {
  RoutineController({
    required RoutineRepository routineRepository,
  }) : _routineRepository = routineRepository {
    final now = DateTime.now();
    // eliminate time
    startDate.value = DateTime(
      now.year,
      now.month,
      now.day,
    );
    endDate.value = DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  // Repository //
  final RoutineRepository _routineRepository;

  // Rx //
  final RxString selectedPeriod = LocaleKeys.period_daily.tr.obs;
  final RxString selectedDateType = LocaleKeys.date_type_start_date.tr.obs;
  final Rx<DateTime> startDate = DateTime.now().obs;
  final Rx<DateTime> endDate = DateTime.now().obs;
  final RxMap<int, bool> selectedDayOfWeeks = <int, bool>{
    RoutineUtils.MONDAY: false,
    RoutineUtils.TUESDAY: false,
    RoutineUtils.WEDNESDAY: false,
    RoutineUtils.THURSDAY: false,
    RoutineUtils.FRIDAY: false,
    RoutineUtils.SATURDAY: false,
    RoutineUtils.SUNDAY: false,
  }.obs;
  final RxMap<int, bool> selectedDays = {
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
    11: false,
    12: false,
    13: false,
    14: false,
    15: false,
    16: false,
    17: false,
    18: false,
    19: false,
    20: false,
    21: false,
    22: false,
    23: false,
    24: false,
    25: false,
    26: false,
    27: false,
    28: false,
    29: false,
    30: false,
    31: false,
  }.obs;
  final RxBool isInfinite = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setStartDateValue(DateTime value) {
    startDate.value = value;
  }

  void setEndDateValue(DateTime value) {
    endDate.value = value;
  }

  Future<void> addRoutine({
    required String title,
    required String period,
    required DateTime startDate,
    required DateTime endDate,
    required List<int> dayOfWeek,
    int? interval,
    bool isInfinite = false,
  }) async {
    await _routineRepository.addRoutine(
      title: title,
      period: period,
      startDate: startDate,
      endDate: endDate,
      dayOfWeek: dayOfWeek,
      interval: interval ?? _getAppropriateInterval(period),
      isInfinite: isInfinite,
    );
  }

  Color getDayOfWeekColor(dayOfWeek) {
    switch (dayOfWeek) {
      case RoutineUtils.SUNDAY:
        return AppColors.red;
      case RoutineUtils.SATURDAY:
        return AppColors.blue;
      default:
        return AppTheme.colorScheme.onPrimary;
    }
  }

  Color getDateTypeColor(String dateType) {
    if (dateType == LocaleKeys.date_type_start_date.tr) {
      return selectedDateType.value == LocaleKeys.date_type_start_date.tr
          ? AppColors.orange
          : AppTheme.colorScheme.onPrimary;
    } else if (dateType == LocaleKeys.date_type_end_date.tr) {
      return selectedDateType.value == LocaleKeys.date_type_end_date.tr
          ? AppColors.blue
          : AppTheme.colorScheme.onPrimary;
    }
    return AppTheme.colorScheme.onPrimary;
  }

  List<int> getTrueSelectedDayOfWeeks() {
    List<int> trueSelectedDayOfWeeks = [];
    selectedDayOfWeeks.forEach((key, value) {
      if (value) {
        trueSelectedDayOfWeeks.add(key);
      }
    });
    return trueSelectedDayOfWeeks;
  }

  int _getAppropriateInterval(String period) {
    if (period == LocaleKeys.period_every_other_day.tr) {
      return 1;
    }
    return 0;
  }

  void setIsInfinite(bool value) {
    isInfinite.value = value;
  }
}
