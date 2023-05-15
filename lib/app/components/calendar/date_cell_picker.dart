import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/data/models/calendar_model.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class DateCellPicker extends GetView<CalendarComponentController> {
  DateCellPicker({
    super.key,
    required this.date,
    required DataStore dataStore,
  }) : _dataStore = dataStore;

  // Store //
  final DataStore _dataStore;

  // Other //
  final CalendarModel date;
  final DateTime now = DateTime.now();

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
          padding: const EdgeInsets.all(0),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          controller.selectedDate.value = DateTime(
            date.year,
            date.month,
            date.day,
          );
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: 23,
                  height: 23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: date.year == now.year &&
                            date.month == now.month &&
                            date.day == now.day
                        ? AppTheme.colorScheme.secondary
                        : Colors.transparent,
                    border: controller.selectedDate.value.year == date.year &&
                            controller.selectedDate.value.month == date.month &&
                            controller.selectedDate.value.day == date.day
                        ? Border.all(
                            color: AppTheme.colorScheme.onPrimary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize:
                          Get.deviceLocale?.languageCode == 'ja' ? 12 : 14,
                      color: date.year == now.year &&
                              date.month == now.month &&
                              date.day == now.day
                          ? AppTheme.colorScheme.primary
                          : AppTheme.colorScheme.onPrimary,
                      fontFamily: AppTypography.getPreferredFont(),
                    ),
                  )),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: date.tasks?.length,
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
                          date.tasks?[index] != null
                              ? date.tasks![index].title
                              : '',
                          style: date.tasks?[index].isDone == true
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
      ),
    );
  }
}
