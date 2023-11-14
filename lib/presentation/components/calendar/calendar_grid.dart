// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/enums/nav_extra.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_draggable_todo.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/calendar/calendar_notifier.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';
import 'package:tasklendar/presentation/state/calendar_page/calendar_page_state.dart';

class CalendarGrid extends HookConsumerWidget {
  CalendarGrid({
    super.key,
    required this.pageNumber,
  });

  // Constance //
  final int pageNumber;

  final GlobalKey gridKey = GlobalKey();

  // Getter //
  RenderBox get gridRenderBox =>
      gridKey.currentContext!.findRenderObject() as RenderBox;
  // List<TodoEntity> get _allTodos => controller.allTodos.toList();

  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TodoEntity?> _allTodos = ref.watch(todoNotifierProvider);

    // notifier //
    final CalendarPageNotifier calendarPageNotifier =
        ref.read(calendarPageNotifierProvider.notifier);
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);

    final state = ref.watch(calendarPageNotifierProvider);
    final AppPageNotifier appPageNotifier =
        ref.read(appPageNotifierProvider.notifier);

    final ColorScheme theme = AppTheme.colorScheme;

    // state //

    final DateTime currentMonth = DateTime(
      now.year,
      now.month - (calendarPageNotifier.initialPage - pageNumber),
    );

    final CalendarPageState calendarPageState =
        ref.watch(calendarPageNotifierProvider);

    final double paddingTop =
        MediaQueryData.fromView(PlatformDispatcher.instance.views.first)
            .padding
            .top;

    final double screenWidth = Screen.width;
    final double screenHeight = Screen.height;

    int year = currentMonth.year;
    int month = currentMonth.month;

    double gridHeight = Screen.height -
        paddingTop -
        calendarPageNotifier.appBarHeight -
        calendarPageNotifier.dayOfWeekHeight -
        calendarPageNotifier.linerIndicatorHeight;

    double todoHeight = (gridHeight / 6 -
            calendarPageNotifier.monthCellDayHeight -
            2 * (calendarPageNotifier.todoLength - 1)) /
        calendarPageNotifier.todoLength;

    final targetDay = useState(DateTime(0, 0, 0));

    return Container(
      key: _containerKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Builder(
            builder: (context) {
              DateTime firstDayOfMonth = currentMonth.firstDayOfMonth();
              DateTime lastDayOfMonth = currentMonth.lastDayOfMonth();
              int firstWeekday = firstDayOfMonth.weekday;
              int daysInMonth = lastDayOfMonth.day;
              int daysInLastMonth = currentMonth.lastDayOfLastMonth().day;
              int totalDays = 42;
              // カレンダーが日曜日始まりの場合、日曜日の値は1になります
              int startWeekDay = DateTime.sunday;

              DateTime? tapStartTime;

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: calendarPageNotifier.dayOfWeekHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 7; i++)
                          Expanded(
                            child: Center(
                              child: Text(
                                calendarPageNotifier.getWeekdayName(
                                  (startWeekDay % 7) + i,
                                  context,
                                ),
                                style: AppTypography.body.copyWith(
                                  color:
                                      now.weekday % 7 == (startWeekDay % 7) + i
                                          ? theme.primary
                                          : theme.onBackground,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Stack(
                  //   children: [
                  SizedBox(
                    height: calendarPageNotifier.linerIndicatorHeight,
                    width: double.infinity,
                  ),
                  // Positioned(
                  //   left: 0,
                  //   child: SlideTransition(
                  //     position: controller.animationController.drive(
                  //       Tween<Offset>(
                  //         begin: Offset(-1, 0),
                  //         end: Offset(screenWidth / 50, 0),
                  //       ).chain(
                  //         CurveTween(
                  //           curve: Curves.easeInOut,
                  //         ),
                  //       ),
                  //     ),
                  //     child: Obx(
                  //       () => Container(
                  //         height: controller.linerIndicatorHeight,
                  //         width: controller.isLoading.value ? 50 : 0,
                  //         color: AppTheme.colorScheme.primary,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTapDown: (details) {
                      tapStartTime = now;
                    },
                    onTapUp: (details) {
                      // 日付を計算
                      // タップした座標
                      final double x = details.localPosition.dx;
                      final double y = details.localPosition.dy;

                      final int weekDay = (x / gridRenderBox.size.width * 7)
                          .floor()
                          .clamp(0, 6);

                      final int dayNumber = (y / gridRenderBox.size.height * 6)
                                  .floor()
                                  .clamp(0, 5) *
                              7 +
                          weekDay +
                          1 -
                          firstWeekday;

                      if (tapStartTime != null) {
                        final tapEndTime = now;
                        final tapDuration =
                            tapEndTime.difference(tapStartTime!);
                        if (tapDuration.inMilliseconds < 300) {
                          appPageNotifier.updateState(
                            AppPageState(
                              appBarTitle:
                                  DateTime(year, month, dayNumber).mMMEd(),
                              titleColor: theme.onBackground,
                              selectedDate: DateTime(year, month, dayNumber),
                            ),
                          );
                          context.goNamed(
                            PageName.todo,
                            extra: {
                              NavExtra.date: DateTime(year, month, dayNumber)
                                  .truncateTime(),
                            },
                          );
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        GridView.builder(
                          key: gridKey,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio:
                                (screenWidth / 7) / (gridHeight / 6),
                          ),
                          itemBuilder: (context, index) {
                            int dayNumber =
                                index - firstWeekday + startWeekDay % 7 + 1;

                            DateTime date = DateTime(year, month, dayNumber);

                            return Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: theme.onBackground
                                          .withOpacity(AppOpacity.barrier),
                                      width:
                                          calendarPageNotifier.monthCellBorder,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: calendarPageNotifier
                                            .monthCellDayHeight,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 1,
                                            bottom: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: date.isSameDay(now)
                                                ? theme.primary
                                                : null,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Text(
                                              date.day.toString(),
                                              style:
                                                  AppTypography.body.copyWith(
                                                color: date.isSameDay(now)
                                                    ? theme.onPrimary
                                                    : date.month == month
                                                        ? theme.onBackground
                                                        : theme.onBackground
                                                            .withOpacity(
                                                                AppOpacity
                                                                    .disabled),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: targetDay.value == date
                                            ? theme.primary
                                            : transparent,
                                        width: targetDay.value == date ? 1 : 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: totalDays,
                        ),
                        Positioned.fill(
                          child: DragTarget(
                            onMove: (details) async {
                              // 座標から日付を計算
                              // gridの座標を取得
                              final Offset gridOffset =
                                  gridRenderBox.localToGlobal(Offset.zero);

                              // ドラッグアイテムの真ん中の座標を計算
                              final double x = details.offset.dx -
                                  gridOffset.dx +
                                  (screenWidth / 7) / 2;
                              final double y = details.offset.dy -
                                  gridOffset.dy +
                                  todoHeight / 2;

                              final int weekDay =
                                  (x / gridRenderBox.size.width * 7)
                                      .floor()
                                      .clamp(0, 6);
                              final int dayNumber =
                                  (y / gridRenderBox.size.height * 6)
                                              .floor()
                                              .clamp(0, 5) *
                                          7 +
                                      weekDay +
                                      1 -
                                      firstWeekday;

                              // await calendarPageNotifier.updateTargetDay(
                              //     DateTime(year, month, dayNumber));

                              targetDay.value =
                                  DateTime(year, month, dayNumber);
                            },
                            onAcceptWithDetails:
                                (DragTargetDetails<TodoEntity> details) async {
                              // 座標から日付を計算
                              // gridの座標を取得
                              final Offset gridOffset =
                                  gridRenderBox.localToGlobal(Offset.zero);

                              // ドラッグアイテムの真ん中の座標を計算
                              final double x = details.offset.dx -
                                  gridOffset.dx +
                                  (screenWidth / 7) / 2;
                              final double y = details.offset.dy -
                                  gridOffset.dy +
                                  todoHeight / 2;

                              final int weekDay =
                                  (x / gridRenderBox.size.width * 7)
                                      .floor()
                                      .clamp(0, 6);
                              final int dayNumber =
                                  (y / gridRenderBox.size.height * 6)
                                              .floor()
                                              .clamp(0, 5) *
                                          7 +
                                      weekDay +
                                      1 -
                                      firstWeekday;

                              targetDay.value = DateTime(0, 0, 0);

                              final TodoEntity todo = details.data;

                              await todoNotifier.updateTodo(
                                todo.copyWith(
                                  date: DateTime(year, month, dayNumber),
                                ),
                              );

                              await todoNotifier.sortTodosByDate();
                              await todoNotifier.calculateMonthCellIndex();
                              final TodoEntity? todoWithMonthCell =
                                  todoNotifier.getTodoById(todo.id);
                              if (todoWithMonthCell != null) {
                                await todoNotifier
                                    .updateDatabaseTodo(todoWithMonthCell);
                              }
                            },
                            builder: (context, list, list2) {
                              return Stack(
                                children: [
                                  ..._allTodos.asMap().entries.map(
                                    (todoEntry) {
                                      final TodoEntity? todo = todoEntry.value;

                                      if (todo == null) {
                                        return Container();
                                      }
                                      // if (!controller.filter[CalendarFilter
                                      //         .showCompleteTodo]! &&
                                      //     todo.isDone) {
                                      //   return Container();
                                      // }
                                      if (todo.date == null) return Container();
                                      if (todo.isDone) {
                                        return Container();
                                      }
                                      if (todo.monthCellIndex >=
                                          calendarPageNotifier.todoLength) {
                                        return Container();
                                      }

                                      if (todo.date!.year == year &&
                                              todo.date!.month == month ||
                                          todo.date!.year == year &&
                                              todo.date!.month - 1 == month ||
                                          todo.date!.year == year &&
                                              todo.date!.month + 1 == month ||
                                          todo.date!.year == year + 1 &&
                                              todo.date!.month == 1 ||
                                          todo.date!.year == year - 1 &&
                                              todo.date!.month == 12) {
                                        int day = todo.date!.day;
                                        if (todo.date!.year == year &&
                                            todo.date!.month == month) {
                                          day = todo.date!.day - 1;
                                        } else if (todo.date!.month - 1 == 0
                                            ? 12 == month
                                            : todo.date!.month - 1 == month) {
                                          final int lastDay = DateTime(
                                            todo.date!.year,
                                            todo.date!.month,
                                            0,
                                          ).day;

                                          day += lastDay - 1;
                                        } else if (todo.date!.month + 1 == 13
                                            ? 1 == month
                                            : todo.date!.month + 1 == month) {
                                          final int daysInMonth = DateTime(
                                            todo.date!.year,
                                            todo.date!.month + 1,
                                            0,
                                          ).day;

                                          day -= daysInMonth + 1;
                                        }

                                        if (!calendarPageNotifier
                                            .isDateInSixWeeks(currentMonth,
                                                todo.date!, DateTime.sunday)) {
                                          return Container();
                                        }

                                        return Positioned(
                                          top: calendarPageNotifier
                                                  .calculateYPosition(
                                                day: day,
                                                firstWeekday: firstWeekday,
                                                gridHeight: gridHeight,
                                                monthCellDayHeight:
                                                    calendarPageNotifier
                                                        .monthCellDayHeight,
                                              ) +
                                              (todo.monthCellIndex *
                                                  todoHeight) +
                                              (todo.monthCellIndex * 2),
                                          left: calendarPageNotifier
                                              .calculateXPosition(
                                            weekday: todo.date!.weekday,
                                            startWeekday: startWeekDay,
                                            screenWidth: screenWidth,
                                          ),
                                          child: CalendarDraggableTodo(
                                            childWidth: calendarPageNotifier
                                                .calculateWidth(
                                              from: todo.date!,
                                              to: todo.date!.add(
                                                Duration(
                                                    days: todo.duration - 1),
                                              ),
                                              screenWidth: screenWidth,
                                            ),
                                            todo: todo,
                                            todoHeight: todoHeight,
                                            draggingWidth: calendarPageNotifier
                                                .calculateWidth(
                                              from: todo.date!,
                                              to: todo.date!.add(
                                                Duration(
                                                    days: todo.duration - 1),
                                              ),
                                              screenWidth: screenWidth,
                                            ),
                                            feedbackWidth: calendarPageNotifier
                                                .calculateWidth(
                                              from: todo.date!,
                                              to: todo.date!.add(
                                                Duration(
                                                    days: todo.duration - 1),
                                              ),
                                              screenWidth: screenWidth,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  ..._allTodos.asMap().entries.map(
                                    (todoEntry) {
                                      final todo = todoEntry.value;

                                      // if (!controller.filter[CalendarFilter
                                      //         .showCompleteTodo]! &&
                                      //     todo.isDone) {
                                      //   return Container();
                                      // }
                                      if (todo == null) return Container();
                                      if (todo.monthCellIndex >=
                                          _allTodos.length) return Container();
                                      if (todo.date == null) return Container();

                                      double width =
                                          calendarPageNotifier.calculateWidth(
                                        from: todo.date!,
                                        to: todo.date!.add(
                                          // durationはdateの日を含むので-1する
                                          Duration(days: todo.duration - 1),
                                        ),
                                        screenWidth: screenWidth,
                                      );

                                      double x = calendarPageNotifier
                                          .calculateXPosition(
                                        weekday: todo.date!.weekday,
                                        startWeekday: startWeekDay,
                                        screenWidth: screenWidth,
                                      );

                                      if ((x + width) > screenWidth) {
                                        if (todo.date!.year == year &&
                                                todo.date!.month == month ||
                                            todo.date!.year == year &&
                                                todo.date!.month - 1 == month ||
                                            todo.date!.year == year &&
                                                todo.date!.month + 1 == month) {
                                          // はみ出した分を何日ぶんか計算する
                                          final int dayCount =
                                              (((x + width) - screenWidth) /
                                                      (screenWidth / 7))
                                                  .ceil();

                                          // 週の末までの日数
                                          final int dayToWeekEnd =
                                              7 - todo.date!.weekday;

                                          // 週末までの日数　＋　はみ出した分の日数 - 1(開始日は含まないため)
                                          DateTime date = todo.date!.add(
                                            Duration(
                                              days: dayToWeekEnd + dayCount - 1,
                                            ),
                                          );

                                          int day = date.day;

                                          // 現在のカレンダーの日付ではない場合は表示しない
                                          if (!calendarPageNotifier
                                              .isDateInSixWeeks(currentMonth,
                                                  date, DateTime.sunday)) {
                                            return Container();
                                          }

                                          if (date.year == year &&
                                              date.month - 1 == month) {
                                            day += daysInLastMonth;
                                          } else if (date.year == year &&
                                              date.month + 1 == month) {
                                            day -= daysInMonth;
                                          }

                                          final double y = calendarPageNotifier
                                                  .calculateYPosition(
                                                day: day,
                                                firstWeekday: firstWeekday,
                                                gridHeight: gridHeight,
                                                monthCellDayHeight:
                                                    calendarPageNotifier
                                                        .monthCellDayHeight,
                                              ) +
                                              (todo.monthCellIndex *
                                                  todoHeight) +
                                              (todo.monthCellIndex * 2);

                                          x = 0.0;

                                          width = calendarPageNotifier
                                              .calculateWidth(
                                            from: date,
                                            to: date.add(
                                              Duration(days: dayCount - 1),
                                            ),
                                            screenWidth: screenWidth,
                                          );

                                          return Positioned(
                                            top: y,
                                            left: x,
                                            child: CalendarDraggableTodo(
                                              todo: todo,
                                              todoHeight: todoHeight,
                                              childWidth: width,
                                              draggingWidth: width,
                                              feedbackWidth:
                                                  calendarPageNotifier
                                                      .calculateWidth(
                                                from: todo.date!,
                                                to: todo.date!.add(
                                                  Duration(
                                                      days: todo.duration - 1),
                                                ),
                                                screenWidth: screenWidth,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
