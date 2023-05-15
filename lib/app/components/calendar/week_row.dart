import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/calendar/date_cell_multi_picker.dart';
import 'package:tasklendar/app/components/calendar/date_cell_picker.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/controllers/custom_bottom_navigation_controller.dart';
import 'package:tasklendar/app/modules/routine/controllers/routine_controller.dart';
import 'package:tasklendar/app/store/data_store.dart';

import 'date_cell.dart';

/// カレンダーの週を表すWidget
class WeekRow extends StatelessWidget {
  const WeekRow({
    super.key,
    required this.week,
    required this.calledFrom,
  });

  final List week;
  final String calledFrom;
  final int MONDAY = 0;
  final int TUESDAY = 1;
  final int WEDNESDAY = 2;
  final int THURSDAY = 3;
  final int FRIDAY = 4;
  final int SATURDAY = 5;
  final int SUNDAY = 6;

  properDateCell({
    required int dayOfWeek,
    String? calledFrom,
  }) {
    if (calledFrom == 'todo') {
      return DateCellPicker(
        date: week[dayOfWeek],
        dataStore: Get.find<DataStore>(),
      );
    } else if (calledFrom == 'routine') {
      return DateCellMultiPicker(
        date: week[dayOfWeek],
        routineController: Get.find<RoutineController>(),
      );
    } else {
      return DateCell(
        date: week[dayOfWeek],
        customBottomNavigationController:
            Get.find<CustomBottomNavigationController>(),
        dataStore: Get.find<DataStore>(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          properDateCell(
            dayOfWeek: MONDAY,
            calledFrom: calledFrom,
          ),
          properDateCell(
            dayOfWeek: TUESDAY,
            calledFrom: calledFrom,
          ),
          properDateCell(
            dayOfWeek: WEDNESDAY,
            calledFrom: calledFrom,
          ),
          properDateCell(
            dayOfWeek: THURSDAY,
            calledFrom: calledFrom,
          ),
          properDateCell(
            dayOfWeek: FRIDAY,
            calledFrom: calledFrom,
          ),
          properDateCell(
            dayOfWeek: SATURDAY,
            calledFrom: calledFrom,
          ),
          properDateCell(
            dayOfWeek: SUNDAY,
            calledFrom: calledFrom,
          ),
        ],
      ),
    );
  }
}
