import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/controllers/custom_bottom_navigation_controller.dart';
import 'package:tasklendar/app/data/models/calendar_model.dart';
import 'package:tasklendar/app/routes/app_pages.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class DateCell extends StatelessWidget {
  DateCell({
    super.key,
    required this.date,
    required DataStore dataStore,
    required CustomBottomNavigationController customBottomNavigationController,
  })  : _dataStore = dataStore,
        _customBottomNavigationController = customBottomNavigationController;

  // Store //
  final DataStore _dataStore;

  // Controller //
  final CustomBottomNavigationController _customBottomNavigationController;

  // Other //
  final CalendarModel date;
  final DateTime now = DateTime.now();

  // Getters //
  DateTime get _currentDate => _dataStore.currentDate.value;

  @override
  Widget build(BuildContext context) {
    // Border? _routineBorder() {
    //   var startDate = startRoutineDate.value;
    //   var endDate = endRoutineDate.value;
    //   if (startDate.year == date.year &&
    //       startDate.month == date.month &&
    //       startDate.day == date.day) {
    //     return Border.all(color: Styles.gray, width: 2);
    //   } else if (endDate.year == date.year &&
    //       endDate.month == date.month &&
    //       endDate.day == date.day) {
    //     return Border.all(color: Styles.blue, width: 2);
    //   } else {
    //     return null;
    //   }
    // }

    // if (calledFrom == 'todoForm') {
    //   return Expanded(
    //     child: ElevatedButton(
    //       style: ElevatedButton.styleFrom(
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //             color: Styles.gray,
    //           ),
    //         ),
    //         padding: EdgeInsets.all(0),
    //         elevation: 0,
    //         shadowColor: Colors.transparent,
    //       ),
    //       onPressed: () {
    //         DataStore.to.selectedDate.value = DateTime(
    //           date.year,
    //           date.month,
    //           date.day,
    //         );
    //       },
    //       child: Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         child: Column(
    //           children: [
    //             Container(
    //                 width: 23,
    //                 height: 23,
    //                 alignment: Alignment.center,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: date.year == now.year &&
    //                           date.month == now.month &&
    //                           date.day == now.day
    //                       ? Styles.red
    //                       : Colors.transparent,
    //                   border: selectedDate.value.year == date.year &&
    //                           selectedDate.value.month == date.month &&
    //                           selectedDate.value.day == date.day
    //                       ? Border.all(color: Styles.gray, width: 2)
    //                       : null,
    //                 ),
    //                 child: Text(
    //                   date.day.toString(),
    //                   style: TextStyle(
    //                     color: date.year == now.year &&
    //                             date.month == now.month &&
    //                             date.day == now.day
    //                         ? Styles.primaryColor
    //                         : Styles.gray,
    //                     fontFamily: 'Fredoka One',
    //                   ),
    //                 )),
    //             Expanded(
    //               child: ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: date.tasks?.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return Container(
    //                     height: 18,
    //                     margin: EdgeInsets.only(bottom: 2),
    //                     child: Container(
    //                       alignment: Alignment.center,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(5),
    //                         color: Styles.blue,
    //                       ),
    //                       child: Text(
    //                         date.tasks?[index] != null
    //                             ? date.tasks![index].task
    //                             : '',
    //                         style: date.tasks?[index].isDone == true
    //                             ? TextStyle(
    //                                 color: Styles.gray,
    //                                 fontFamily: 'EbiharaNoKuseji',
    //                                 fontWeight: FontWeight.w900,
    //                                 decoration: TextDecoration.lineThrough,
    //                                 decorationThickness: 3,
    //                               )
    //                             : TextStyle(
    //                                 color: Styles.gray,
    //                                 fontFamily: 'EbiharaNoKuseji',
    //                                 fontWeight: FontWeight.w900,
    //                               ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // } else if (calledFrom == 'routineForm') {
    //   return Expanded(
    //     child: ElevatedButton(
    //       style: ElevatedButton.styleFrom(
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //             color: Styles.gray,
    //           ),
    //         ),
    //         padding: EdgeInsets.all(0),
    //         elevation: 0,
    //         shadowColor: Colors.transparent,
    //       ),
    //       onPressed: () {
    //         // TODO:startDate と endDateのラジオボタンを設置しそこをみて処理を分ける
    //         DataStore.to.selectedDate.value = DateTime(
    //           date.year,
    //           date.month,
    //           date.day,
    //         );
    //       },
    //       child: Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         child: Column(
    //           children: [
    //             Container(
    //                 width: 23,
    //                 height: 23,
    //                 alignment: Alignment.center,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: date.year == now.year &&
    //                           date.month == now.month &&
    //                           date.day == now.day
    //                       ? Styles.red
    //                       : Colors.transparent,
    //                   border: _routineBorder(),
    //                 ),
    //                 child: Text(
    //                   date.day.toString(),
    //                   style: TextStyle(
    //                     color: date.year == now.year &&
    //                             date.month == now.month &&
    //                             date.day == now.day
    //                         ? Styles.primaryColor
    //                         : Styles.gray,
    //                     fontFamily: 'Fredoka One',
    //                   ),
    //                 )),
    //             Expanded(
    //               child: ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: date.tasks?.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return Container(
    //                     height: 18,
    //                     margin: EdgeInsets.only(bottom: 2),
    //                     child: Container(
    //                       alignment: Alignment.center,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(5),
    //                         color: Styles.blue,
    //                       ),
    //                       child: Text(
    //                         date.tasks?[index] != null
    //                             ? date.tasks![index].task
    //                             : '',
    //                         style: date.tasks?[index].isDone == true
    //                             ? TextStyle(
    //                                 color: Styles.gray,
    //                                 fontFamily: 'EbiharaNoKuseji',
    //                                 fontWeight: FontWeight.w900,
    //                                 decoration: TextDecoration.lineThrough,
    //                                 decorationThickness: 3,
    //                               )
    //                             : TextStyle(
    //                                 color: Styles.gray,
    //                                 fontFamily: 'EbiharaNoKuseji',
    //                                 fontWeight: FontWeight.w900,
    //                               ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // } else {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.colorScheme.onPrimary),
        ),
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
                border: _currentDate.year == date.year &&
                        _currentDate.month == date.month &&
                        _currentDate.day == date.day
                    ? Border.all(
                        color: AppTheme.colorScheme.onPrimary,
                        width: 2,
                      )
                    : null,
              ),
              child: TextButton(
                onPressed: () {
                  _dataStore.setCurrentDateValue(DateTime(
                    date.year,
                    date.month,
                    date.day,
                  ));
                  _customBottomNavigationController.changePage(
                    _customBottomNavigationController.TODO_PAGE,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
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
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: date.tasks?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 18,
                    margin: const EdgeInsets.only(bottom: 2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        _dataStore.setCurrentDateValue(DateTime(
                          date.year,
                          date.month,
                          date.day,
                        ));
                        _customBottomNavigationController.changePage(
                          _customBottomNavigationController.TODO_PAGE,
                          param: '?task_id=${date.tasks?[index].id}',
                        );
                      },
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
    );
    // }
  }
}
