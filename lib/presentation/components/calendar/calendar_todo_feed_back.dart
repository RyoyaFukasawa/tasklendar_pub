// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_content.dart';
import 'package:tasklendar/presentation/components/hexagon_container/hexagon_container.dart';

class CalendarTodoFeedBack extends HookConsumerWidget {
  const CalendarTodoFeedBack({
    super.key,
    required this.todo,
    required this.height,
    required this.width,
  });

  final TodoEntity todo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return todo.duration == 1
        ? Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(5),
            child: CalendarTodoContent(
              height: height,
              width: width,
              backgroundColor: todo.color,
              name: todo.name,
              color: todo.color,
            ),
          )
        : Material(
            elevation: 10,
            color: transparent,
            child: HexagonContainer(
              width: width,
              height: height,
              color: todo.color,
              child: CalendarTodoContent(
                height: height,
                width: width,
                backgroundColor: transparent,
                name: todo.name,
                color: todo.color,
              ),
            ),
          );
  }
}
