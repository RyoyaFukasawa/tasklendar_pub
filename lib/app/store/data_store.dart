import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/models/calendar_model.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';

class DataStore {
  // the current display date
  final Rx<DateTime> currentDate = DateTime.now().obs;
  // the current user
  final Rx<User?> loggedInUser = Rx<User?>(null);
  // the calendar list for each month
  final RxMap<int, Map<int, List<List<dynamic>>>> calendarList =
      <int, Map<int, List<List>>>{}.obs;
  // the calendar days list for each month
  final RxMap<int, Map<int, Map<int, List<CalendarModel>>>> calendarDaysList =
      <int, Map<int, Map<int, List<CalendarModel>>>>{}.obs;
  // the todo list for each month
  final RxMap<int, RxMap<int, RxMap<int, RxList<TodoModel>>>> todoList =
      <int, RxMap<int, RxMap<int, RxList<TodoModel>>>>{}.obs;

  void setLoggedInUserValue(User? user) {
    loggedInUser.value = user;
  }

  void setCurrentDateValue(DateTime value) {
    currentDate.value = value;
  }

  void setCalendarListValue(
    int year,
    int month,
    List days,
    int roupIndex,
    int end,
  ) {
    calendarList.putIfAbsent(year, () => <int, List<List<dynamic>>>{});
    calendarList[year]!.putIfAbsent(month, () => []);

    final index = calendarList[year]![month]!.indexWhere((week) {
      return week.any((existingDay) {
        return existingDay.day == days[roupIndex].day &&
            existingDay.month == days[roupIndex].month &&
            existingDay.year == days[roupIndex].year;
      });
    });

    if (index != -1) {
      _updateCalendarListValue(year, month, index, days, roupIndex, end);
    } else {
      _addCalendarListValue(year, month, days, roupIndex, end);
    }
  }

  void _updateCalendarListValue(
    int year,
    int month,
    int index,
    List days,
    int roupIndex,
    int end,
  ) {
    calendarList[year]![month]![index] = days.sublist(roupIndex, end);
  }

  void _addCalendarListValue(
    int year,
    int month,
    List days,
    int roupIndex,
    int end,
  ) {
    calendarList[year]![month]!.add(days.sublist(roupIndex, end));
  }

  void addCalendarDaysListValue(
    int year,
    int month,
    int day,
    CalendarModel calendarModel,
  ) {
    calendarDaysList.putIfAbsent(
        year, () => <int, Map<int, List<CalendarModel>>>{});
    calendarDaysList[year]!
        .putIfAbsent(month, () => <int, List<CalendarModel>>{});
    calendarDaysList[year]![month]!.putIfAbsent(day, () => []);

    calendarDaysList[year]![month]![day]!.add(calendarModel);
  }

  void setTodoListValue(
    int year,
    int month,
    int day,
    TodoModel todoModel,
  ) {
    todoList.putIfAbsent(
        year, () => <int, RxMap<int, RxList<TodoModel>>>{}.obs);
    todoList[year]!.putIfAbsent(month, () => <int, RxList<TodoModel>>{}.obs);
    todoList[year]![month]!.putIfAbsent(day, () => <TodoModel>[].obs);
    final index = todoList[year]![month]![day]!
        .indexWhere((element) => element.id == todoModel.id);
    if (index >= 0) {
      _updateTodoListValue(year, month, day, todoModel, index);
    } else {
      _addTodoListValue(year, month, day, todoModel);
    }
  }

  void deleteTodoListValue(int year, int month, int day, String id) {
    todoList[year]![month]![day]!.removeWhere((element) => element.id == id);
  }

  void _updateTodoListValue(
    int year,
    int month,
    int day,
    TodoModel todoModel,
    int index,
  ) {
    todoList[year]![month]![day]![index] = todoModel;
  }

  void _addTodoListValue(
    int year,
    int month,
    int day,
    TodoModel todoModel,
  ) {
    todoList[year]![month]![day]!.add(todoModel);
  }

  // TODOここより下はglobalのstoreにいらないかも

  // the startRoutineDate in routine_form
  final Rx<DateTime> startRoutineDate = DateTime.now().obs;

  // the endRoutineDate in routine_form
  final Rx<DateTime> endRoutineDate = DateTime.now().obs;
}
