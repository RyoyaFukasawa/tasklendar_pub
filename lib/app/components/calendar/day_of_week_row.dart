import 'package:flutter/material.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/calendar_utils.dart';

import 'day_of_week_cell.dart';

class DayOfWeekRow extends StatelessWidget {
  const DayOfWeekRow({super.key});
  final int MONDAY = 0;
  final int TUESDAY = 1;
  final int WEDNESDAY = 2;
  final int THURSDAY = 3;
  final int FRIDAY = 4;
  final int SATURDAY = 5;
  final int SUNDAY = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.colorScheme.onPrimary,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[MONDAY],
          ),
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[TUESDAY],
          ),
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[WEDNESDAY],
          ),
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[THURSDAY],
          ),
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[FRIDAY],
          ),
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[SATURDAY],
          ),
          DayOfWeekCell(
            dayOfWeek: CalendarUtils.dayOfWeek[SUNDAY],
          ),
        ],
      ),
    );
  }
}
