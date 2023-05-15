import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/calendar/day_of_week_row.dart';
import 'package:tasklendar/app/components/calendar/week_row.dart';

class CalendarPage extends GetView {
  CalendarPage({
    super.key,
    required this.weeks,
    required this.calledFrom,
  });

  final weeks;
  final calledFrom;
  final int FIRST_WEEK = 0;
  final int SECOND_WEEK = 1;
  final int THIRD_WEEK = 2;
  final int FORTH_WEEK = 3;
  final int FIFTH_WEEK = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DayOfWeekRow(),
          WeekRow(
            week: weeks[FIRST_WEEK],
            calledFrom: calledFrom,
          ),
          WeekRow(
            week: weeks[SECOND_WEEK],
            calledFrom: calledFrom,
          ),
          WeekRow(
            week: weeks[THIRD_WEEK],
            calledFrom: calledFrom,
          ),
          WeekRow(
            week: weeks[FORTH_WEEK],
            calledFrom: calledFrom,
          ),
          WeekRow(
            week: weeks[FIFTH_WEEK],
            calledFrom: calledFrom,
          ),
        ],
      ),
    );
  }
}
