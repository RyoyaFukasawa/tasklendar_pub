// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/factory/group_factory.dart';
import 'package:tasklendar/domain/factory/todo_factory.dart';

class TodoFactoryImpl implements TodoFactory {
  TodoFactoryImpl(
      // {
      // required GroupFactory groupFactory,
      // }
      )
  // : _groupFactory = groupFactory
  ;

  // final GroupFactory _groupFactory;

  @override
  Future<TodoEntity> createTodo({
    required String id,
    required String name,
    required DateTime date,
    required int duration,
    required int color,
    required bool isDone,
    String? groupId,
    required DateTime updatedAt,
  }) async {
    return TodoEntity(
      id: id,
      name: name,
      date: date,
      duration: duration,
      color: Color(color),
      isDone: isDone,
      monthCellIndex: 99,
      // group: groupId == null
      //     ? null
      //     : await _groupFactory.createGroupFromId(
      //         id: groupId,
      //       ),
      group: null,
      updatedAt: updatedAt,
    );
  }
}
