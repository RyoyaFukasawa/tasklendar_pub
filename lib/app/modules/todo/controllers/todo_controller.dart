import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/data/repository/todo_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:intl/date_symbol_data_local.dart';

class TodoController extends GetxController {
  TodoController({
    required TodoRepository todoRepository,
    required DataStore dataStore,
  })  : _todoRepository = todoRepository,
        _dataStore = dataStore;

  // Repository //
  final TodoRepository _todoRepository;

  // Store //
  final DataStore _dataStore;

  // Rx //
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final todoStream = _todoRepository.todoStream();

    // listen to changes in todoStream and update _todoList.
    todoStream.listen((List<TodoModel> todoModels) async {
      await _setTodoList(todoModels);
      _sortTodoList();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addTodo({
    required DateTime date,
    required String title,
    bool isPined = false,
    bool isDone = false,
    int priority = 0,
  }) async {
    try {
      final priority =
          _dataStore.todoList[date.year]?[date.month]?[date.day]?.length ?? 0;
      await _todoRepository.addTodo(
        date: date,
        title: title,
        isPinned: isPined,
        isDone: isDone,
        priority: priority,
      );
    } catch (e) {
      print('addTodo failed: $e');
    }
  }

  Future<void> updateTodo({
    required String id,
    DateTime? date,
    String? title,
    bool? isPined,
    bool? isDone,
    int? priority,
  }) async {
    try {
      final TodoModel? todo = await _todoRepository.getTodo(id: id);
      if (todo == null) {
        error.value = 'Todo not found';
        return;
      }
      final DateTime originalDate = todo.date;

      final DateTime newDate = date ?? todo.date;

      await _todoRepository.updateTodo(
        id: id,
        date: date ?? todo.date,
        title: title ?? todo.title,
        isPinned: isPined ?? todo.isPinned,
        isDone: isDone ?? todo.isDone,
        priority: priority ?? todo.priority,
      );
      if (originalDate != newDate) {
        _removeTodoFromList(id);
      }
    } catch (e) {
      print('updateTodo failed: $e');
    }
  }

  Future<TodoModel?>? getTodo(String id) {
    try {
      return _todoRepository.getTodo(
        id: id,
      );
    } catch (e) {
      print('getTodo failed: $e');
    }
    return null;
  }

  Future<void> updateTodosPriority(List<TodoModel> tasks) async {
    try {
      await _todoRepository.updateTodosPriority(tasks);
    } catch (e) {
      print('updateTodosPriority failed: $e');
    }
  }

  Future<void> toggleIsDone(String id, bool isDone) async {
    try {
      await _todoRepository.toggleIsDone(id: id, isDone: !isDone);
    } catch (e) {
      print('toggleIsDone failed: $e');
    }
  }

  Future<void> toggleIsPinned(String id, bool isPinned) async {
    try {
      await _todoRepository.toggleIsPinned(id: id, isPinned: !isPinned);
    } catch (e) {
      print('toggleIsPined failed: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _removeTodoFromList(id);
      await _todoRepository.deleteTodo(id: id);
    } catch (e) {
      print('deleteTodo failed: $e');
    }
  }

  String changeFormat(DateTime date) {
    final Locale? locale = Get.deviceLocale;
    if (locale?.languageCode == 'ja') {
      initializeDateFormatting('ja_JP');
      final formatter = DateFormat('M月d日(E)', locale?.languageCode);
      final String formattedToday = formatter.format(date);
      return formattedToday;
    } else {
      final formatter = DateFormat('E, MMM d');
      final String formattedToday = formatter.format(date);
      return formattedToday;
    }
  }

  // Returns a list of TodoModels for the current day
  List<TodoModel>? getTodosForDate(DateTime date) {
    return _dataStore.todoList[date.year]?[date.month]?[date.day];
  }

  //TODO _clear()必要？
  Future<void> _setTodoList(List<TodoModel> todoModels) async {
    // todoList.clear();
    for (var todoModel in todoModels) {
      final year = todoModel.date.year;
      final month = todoModel.date.month;
      final day = todoModel.date.day;
      _dataStore.setTodoListValue(year, month, day, todoModel);
    }
  }

  // This function sorts the list of Todo objects in the todoList map.
  void _sortTodoList() {
    final int year = _dataStore.currentDate.value.year;
    final int month = _dataStore.currentDate.value.month;
    final int day = _dataStore.currentDate.value.day;
    const int UP = -1;
    const int DOWN = 1;

    if (_dataStore.todoList[year]?[month]?[day] != null) {
      _dataStore.todoList[year]![month]![day]!.sort(
        (a, b) {
          if (a.isPinned != b.isPinned) {
            return a.isPinned ? UP : DOWN;
          }

          if (a.isDone != b.isDone) {
            return a.isDone ? DOWN : UP;
          }

          return a.priority.compareTo(b.priority);
        },
      );
    }
  }

  // This function removes a task from the list of tasks for the current day.
  // The function takes the id of the task as input.
  // It loops through the list of tasks for the current day and removes the task with the matching id.
  void _removeTodoFromList(String id) {
    final int year = _dataStore.currentDate.value.year;
    final int month = _dataStore.currentDate.value.month;
    final int day = _dataStore.currentDate.value.day;

    _dataStore.deleteTodoListValue(year, month, day, id);
  }
}
