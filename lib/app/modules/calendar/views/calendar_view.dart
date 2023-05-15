import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/calendar/calendar_page.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/modules/todo/components/todo_list.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/calendar_utils.dart';

import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  CalendarView({
    Key? key,
    required DataStore dataStore,
    required CalendarComponentController calendarComponentController,
    required AppController appController,
  })  : _dataStore = dataStore,
        _calendarComponentController = calendarComponentController,
        _appController = appController,
        _pageController = PageController(
          initialPage: dataStore.currentDate.value.month - 1,
        ),
        super(key: key);

  // Store //
  final DataStore _dataStore;

  // Controller //
  final CalendarComponentController _calendarComponentController;
  final AppController _appController;
  final PageController _pageController;

  // Getter //
  DateTime get currentDate => _dataStore.currentDate.value;
  RxMap<int, RxMap<int, RxMap<int, RxList<TodoModel>>>> get todoList =>
      _dataStore.todoList;
  RxMap<int, Map<int, List<List<dynamic>>>> get calendarList =>
      _dataStore.calendarList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 80,
        leading: Obx(
          () => Container(
            alignment: Alignment.center,
            child: Container(
              child: DropdownButton(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 1,
                dropdownColor: AppTheme.colorScheme.primary,
                underline: Container(
                  color: AppTheme.colorScheme.primary,
                ),
                icon: Icon(
                  FontAwesomeIcons.caretDown,
                  color: AppTheme.colorScheme.onPrimary,
                  size: 15,
                ),
                value: controller.currentYear.value,
                onChanged: (value) {
                  controller.currentYear.value = value as int;
                  _calendarComponentController
                      .createCalendarListForYear(controller.currentYear.value);
                },
                items: _calendarComponentController.yearList
                    .map((year) => DropdownMenuItem(
                          value: year,
                          child: Text(
                            year.toString(),
                            style: AppTypography.h5,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _dataStore.setCurrentDateValue(DateTime.now());
              controller.currentYear.value = DateTime.now().year;
              _appController.goToPage(
                  _pageController, DateTime.now().month - 1);
            },
            child: Text(
              'tody',
              style: AppTypography.h5,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              _calendarComponentController
                  .createCalendarListForYear(controller.currentYear.value);
              return PageView.builder(
                itemCount: calendarList[controller.currentYear.value]!.length,
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  final targetKey = calendarList[controller.currentYear.value]!
                      .keys
                      .firstWhere((key) => key == index + 1);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        CalendarUtils.months[targetKey]!,
                        style: AppTypography.h5,
                      ),
                      const Gap(10),
                      Flexible(
                        fit: FlexFit.loose,
                        child: CalendarPage(
                          weeks: calendarList[controller.currentYear.value]![
                              targetKey],
                          calledFrom: 'calendar',
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
