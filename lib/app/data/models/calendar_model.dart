import 'package:tasklendar/app/data/models/todo_model.dart';

class CalendarModel {
  final String dayOfWeek;
  final int day;
  final int month;
  final int year;
  final bool isEnable;
  final List<TodoModel>? tasks;

  CalendarModel({
    required this.year,
    required this.month,
    required this.day,
    required this.dayOfWeek,
    this.isEnable = false,
    this.tasks,
  });
}
