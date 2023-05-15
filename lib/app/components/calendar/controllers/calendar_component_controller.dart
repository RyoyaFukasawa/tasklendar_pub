import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/models/calendar_model.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/utils/calendar_utils.dart';

class CalendarComponentController extends GetxController {
  CalendarComponentController({
    required DataStore dataStore,
  }) : _dataStore = dataStore;

  // Store //
  final DataStore _dataStore;

  // Rx //
  final RxList yearList = [].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  // Other //
  final DateTime _today = DateTime.now();
  final List _days = [];

  @override
  void onInit() {
    super.onInit();
    createCalendarListForYear(
      _dataStore.loggedInUser.value?.metadata.creationTime?.year ?? _today.year,
    );
    _createYearList();
  }

  void createCalendarListForYear(int year) {
    for (var month = 1; month <= 12; month++) {
      _createCalendarList(year, month);
    }
  }

  void setSelectedDateValue(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> _createCalendarList(int year, int month) async {
    _days.clear();
    _prevMonthDays(year, month);
    _currentMonthDays(year, month);
    _nextMonthDays(year, month);
    _convertToCalendarList(year, month);
    _convertToCalendarDaysList(year, month);
  }

  void _currentMonthDays(int year, int month) {
    final int lastDate = DateTime(year, month + 1, 0).day;
    for (var day = 1; day <= lastDate; day++) {
      _days.add(CalendarModel(
        dayOfWeek:
            CalendarUtils.dayOfWeek[(DateTime(year, month, day).weekday - 1)],
        day: day,
        month: month,
        year: year,
        isEnable: true,
        tasks: _dataStore.todoList[year]?[month]?[day] ?? [],
      ));
    }
  }

  void _prevMonthDays(int year, int month) {
    final int firstDayOfWeek = DateTime(year, month).weekday;
    final int prevLastDate = DateTime(year, month, 0).day;
    final _year = DateTime(year, month - 1).year;
    final _month = DateTime(year, month - 1).month;
    for (var day = prevLastDate - (firstDayOfWeek - 2);
        day <= prevLastDate;
        day++) {
      _days.add(CalendarModel(
        year: _year,
        month: _month,
        day: day,
        dayOfWeek: CalendarUtils
            .dayOfWeek[(DateTime(year, month - 1, day).weekday - 1)],
        tasks: _dataStore.todoList[_year]?[_month]?[day] ?? [],
      ));
    }
  }

  void _nextMonthDays(int year, int month) {
    final int lastDayOfWeek = DateTime(year, month + 1, 0).weekday;
    final _year = DateTime(year, month + 1).year;
    final _month = DateTime(year, month + 1).month;
    for (var day = 1; day <= 7 - lastDayOfWeek; day++) {
      _days.add(CalendarModel(
        year: _year,
        month: _month,
        day: day,
        dayOfWeek: CalendarUtils
            .dayOfWeek[(DateTime(year, month + 1, day).weekday - 1)],
        tasks: _dataStore.todoList[_year]?[_month]?[day] ?? [],
      ));
    }
  }

  void _convertToCalendarList(int year, int month) {
    for (var i = 0; i < _days.length; i += 7) {
      int end = i + 7 < _days.length ? i + 7 : _days.length;
      _dataStore.setCalendarListValue(year, month, _days, i, end);
    }
  }

  void _convertToCalendarDaysList(int year, int month) {
    for (var i = 0; i < _days.length; i++) {
      _dataStore.addCalendarDaysListValue(
        _days[i].year,
        _days[i].month,
        _days[i].day,
        _days[i],
      );
    }
  }

  void _createYearList() {
    final registeredYear =
        _dataStore.loggedInUser.value?.metadata.creationTime?.year ??
            _today.year;

    for (var i = registeredYear; i < _today.year + 3; i++) {
      yearList.add(i);
    }
  }
}
