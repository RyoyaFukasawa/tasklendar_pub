// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/factory/todo_factory.dart';

class TodoFactoryImpl implements TodoFactory {
  TodoFactoryImpl();

  @override
  Future<TodoEntity> createTodo({
    required String id,
    required String name,
    DateTime? date,
    required int duration,
    required int times,
    required int currentTimes,
    required int color,
    required bool isDone,
    required int monthCellIndex,
    String? groupId,
    required DateTime updatedAt,
    required DateTime createdAt,
  }) async {
    return TodoEntity(
      id: id,
      name: name,
      date: date,
      duration: duration,
      times: times,
      currentTimes: currentTimes,
      color: Color(color),
      isDone: isDone,
      monthCellIndex: monthCellIndex,
      groupId: groupId,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}
