import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/data/models/calendar_model.dart';
import 'package:tasklendar/app/modules/routine/controllers/routine_controller.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/generated/locales.g.dart';

class DateCellMultiPicker extends GetView<CalendarComponentController> {
  DateCellMultiPicker({
    super.key,
    required CalendarModel date,
    required RoutineController routineController,
  })  : _routineController = routineController,
        _calendarModel = date,
        date = DateTime(
          date.year,
          date.month,
          date.day,
        );

  // Controller //
  final RoutineController _routineController;

  // Other //
  final CalendarModel _calendarModel;
  final DateTime now = DateTime.now();
  final DateTime date;

  // Getters //
  DateTime get _startDate => _routineController.startDate.value;
  DateTime get _endDate => _routineController.endDate.value;
  String get _selectedDateType => _routineController.selectedDateType.value;

  Border? _selectedBorder() {
    if (_selectedDateType == LocaleKeys.date_type_end_date.tr) {
      if (_endDate == date) {
        return Border.all(
          color: _routineController.isInfinite.value
              ? Colors.transparent
              : AppColors.blue,
          width: 2,
        );
      } else if (_startDate == date) {
        return Border.all(
          color: AppColors.orange,
          width: 2,
        );
      }
    } else {
      if (_startDate == date) {
        return Border.all(
          color: AppColors.orange,
          width: 2,
        );
      } else if (_endDate == date) {
        return Border.all(
          color: _routineController.isInfinite.value
              ? Colors.transparent
              : AppColors.blue,
          width: 2,
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppTheme.colorScheme.onPrimary,
              ),
            ),
            padding: EdgeInsets.all(0),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            if (_selectedDateType == LocaleKeys.date_type_start_date.tr) {
              _routineController.setStartDateValue(DateTime(
                date.year,
                date.month,
                date.day,
              ));
            } else if (_selectedDateType == LocaleKeys.date_type_end_date.tr) {
              _routineController.setIsInfinite(false);
              _routineController.setEndDateValue(DateTime(
                date.year,
                date.month,
                date.day,
              ));
            }
          },
          child: Obx(
            () => Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: Get.locale?.languageCode == 'ja' ? 26 : 23,
                    height: Get.locale?.languageCode == 'ja' ? 26 : 23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: date.year == now.year &&
                              date.month == now.month &&
                              date.day == now.day
                          ? AppTheme.colorScheme.secondary
                          : Colors.transparent,
                      border: _selectedBorder(),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: date.year == now.year &&
                                date.month == now.month &&
                                date.day == now.day
                            ? AppTheme.colorScheme.primary
                            : AppTheme.colorScheme.onPrimary,
                        fontFamily: AppTypography.getPreferredFont(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _calendarModel.tasks?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 18,
                          margin: EdgeInsets.only(bottom: 2),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.blue,
                            ),
                            child: Text(
                              _calendarModel.tasks?[index] != null
                                  ? _calendarModel.tasks![index].title
                                  : '',
                              style: _calendarModel.tasks?[index].isDone == true
                                  ? TextStyle(
                                      color: AppTheme.colorScheme.onPrimary,
                                      fontFamily: 'EbiharaNoKuseji',
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3,
                                    )
                                  : TextStyle(
                                      color: AppTheme.colorScheme.onPrimary,
                                      fontFamily: 'EbiharaNoKuseji',
                                      fontWeight: FontWeight.w900,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
