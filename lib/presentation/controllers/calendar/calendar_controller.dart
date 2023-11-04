// // Dart imports:
// import 'dart:async';

// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:get/get.dart';

// // Project imports:
// import 'package:tasklendar/core/enums/calendar_filter.dart';
// import 'package:tasklendar/core/extension/date_time_extensiton.dart';
// import 'package:tasklendar/core/logs/log.dart';
// import 'package:tasklendar/domain/entities/todo_entity.dart';
// import 'package:tasklendar/domain/usecases/calendar/get_week_day_name_usecase.dart';
// import 'package:tasklendar/domain/usecases/todo/get_todo_by_id_usecase.dart';
// import 'package:tasklendar/domain/usecases/todo/get_todos_usecase.dart';
// import 'package:tasklendar/domain/usecases/todo/update_todo_usecase.dart';
// import 'package:tasklendar/presentation/controllers/base_controller.dart';

// class CalendarController extends BaseController
//     with GetSingleTickerProviderStateMixin {
//   CalendarController({
//     required GetTodosUseCase getTodosUseCase,
//     required GetTodoByIdUseCase getTodoByIdUseCase,
//     required GetWeekDayNameUseCase getWeekDayNameUseCase,
//     required UpdateTodoUseCase updateTodoUseCase,
//     required super.globalState,
//   })  : _getTodosUseCase = getTodosUseCase,
//         _getTodoByIdUseCase = getTodoByIdUseCase,
//         _getWeekDayNameUseCase = getWeekDayNameUseCase,
//         _updateTodoUseCase = updateTodoUseCase;

//   // usecase //
//   final GetTodosUseCase _getTodosUseCase;
//   final GetTodoByIdUseCase _getTodoByIdUseCase;
//   final GetWeekDayNameUseCase _getWeekDayNameUseCase;
//   final UpdateTodoUseCase _updateTodoUseCase;

//   // controller //
//   late AnimationController animationController;
//   late PageController pageController;

//   // Rx //
//   final RxBool isLoading = false.obs;
//   final Rx<DateTime> targetDay = DateTime.now().obs;
//   final RxMap<CalendarFilter, bool> filter = {
//     CalendarFilter.showCompleteTodo: false,
//   }.obs;
//   final RxString isDraggingId = ''.obs;
//   final Rx<DateTime> currentMonth = DateTime.now().obs;

//   // constance //
//   final int initialPage = 5000;
//   final double dayOfWeekHeight = 26;
//   final double linerIndicatorHeight = 4;
//   final double monthCellDayHeight = 23;
//   final double monthHeight = 40;
//   final double monthCellBorder = 0.5;
//   final int todoLength = 5;

//   @override
//   Future<void> onInit() async {
//     super.onInit();

//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );

//     pageController = PageController(
//       initialPage: initialPage,
//     );

//     await getTodoList();
//     await sortTodos();
//     await calculateMonthCellIndex();
//   }

//   Future<List<TodoEntity>> getTodoList() async {
//     try {
//       final List<TodoEntity> todos = await _getTodosUseCase.execute();
//       updateAllTodos(todos);

//       return todos;
//     } catch (e) {
//       Log.error(e.toString());
//       return [];
//     }
//   }

//   Future<TodoEntity?> fetchTodoById(String id) async {
//     try {
//       final TodoEntity todo = await _getTodoByIdUseCase.execute(
//         id,
//       );
//       return todo;
//     } catch (e) {
//       Log.error(e.toString());
//       return null;
//     }
//   }

//   Future<void> updateTodo(
//     String id, {
//     String? name,
//     DateTime? date,
//     int? duration,
//     bool? isDone,
//     String? groupId,
//   }) async {
//     try {
//       await _updateTodoUseCase.execute(
//         id,
//         name: name,
//         date: date,
//         duration: duration,
//         isDone: isDone,
//         groupId: groupId,
//       );
//     } catch (e) {
//       Log.error(e.toString());
//     }
//   }

//   getWeekdayName(int weekday) {
//     return _getWeekDayNameUseCase.execute(weekday);
//   }

//   double calculateYPosition({
//     required int day,
//     required int firstWeekday,
//     required double gridHeight,
//     required double monthCellDayHeight,
//   }) {
//     int row = 0;
//     // Calculate the week number
//     row = (firstWeekday + day) ~/ 7;
//     if (firstWeekday + day < 0) {
//       row = -1;
//     }
//     return (row * gridHeight / 6) + monthCellDayHeight;
//   }

//   double calculateXPosition({
//     required int weekday,
//     required int startWeekday,
//   }) {
//     double gridWidth = Get.width;
//     int offset = weekday - (startWeekday % 7);
//     return offset * (gridWidth / 7);
//   }

//   double calculateWidth({
//     required DateTime from,
//     required DateTime to,
//   }) {
//     int days = to.difference(from).inDays + 1;
//     return days * Get.width / 7 - 3;
//   }

//   Future<void> calculateMonthCellIndex() async {
//     isLoading.value = true;
//     for (var todo in allTodos) {
//       final todoStart = todo.date;
//       final overlapDuration = <TodoEntity>[];

//       for (var otherTodo in allTodos) {
//         if (!otherTodo.isDone || (filter[CalendarFilter.showCompleteTodo]!)) {
//           final otherTodoStart = otherTodo.date;
//           final otherTodoEnd = otherTodo.date.add(
//             Duration(
//               days: otherTodo.duration - 1,
//             ),
//           );

//           if ((todoStart.isBefore(otherTodoEnd) &&
//                   todoStart.isAfter(otherTodoStart)) ||
//               todoStart == otherTodoStart ||
//               todoStart == otherTodoEnd) {
//             overlapDuration.add(otherTodo);
//           }
//         }
//       }

//       final Set<int?> usedIndexes = <int?>{
//         for (TodoEntity overlapTodo in overlapDuration)
//           if (overlapTodo.id != todo.id) overlapTodo.monthCellIndex
//       };

//       final overlapDurationIndex = Iterable.generate(overlapDuration.length)
//           .firstWhere((i) => !usedIndexes.contains(i), orElse: () => null);

//       await updateTodoInList(todo.id, monthCellIndex: overlapDurationIndex);
//     }
//     isLoading.value = false;
//   }

//   bool isDateInSixWeeks(
//     DateTime currentMonth,
//     DateTime date,
//     int firstDayOfWeek,
//   ) {
//     int firstWeekday = currentMonth.firstDayOfMonth().weekday;

//     int totalDays = 42;

//     // 6週間で1~42日までだから
//     DateTime startDate = DateTime(
//       currentMonth.year,
//       currentMonth.month,
//       1 - firstWeekday + (firstDayOfWeek % 7),
//     );
//     DateTime endDate = DateTime(
//       currentMonth.year,
//       currentMonth.month,
//       totalDays - firstWeekday + (firstDayOfWeek % 7),
//     );

//     return date.isAfter(startDate) && date.isBefore(endDate) ||
//         date == startDate ||
//         date == endDate;
//   }
// }
