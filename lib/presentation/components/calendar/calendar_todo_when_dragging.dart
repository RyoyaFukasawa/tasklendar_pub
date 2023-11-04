// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_content.dart';
import 'package:tasklendar/presentation/components/hexagon_container/hexagon_container.dart';

class CalendarTodoWhenDragging extends HookConsumerWidget {
  const CalendarTodoWhenDragging({
    super.key,
    required this.height,
    required this.width,
    required this.todo,
  });

  final TodoEntity todo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return todo.duration == 1
    //     ? CalendarTodoContent(
    //         height: height,
    //         width: width,
    //         backgroundColor: todo.color.withOpacity(
    //           AppOpacity.disabled,
    //         ),
    //         name: todo.name,
    //         color: todo.color,
    //       )
    //     : HexagonContainer(
    //         width: width,
    //         height: height,
    //         color: todo.color.withOpacity(
    //           AppOpacity.disabled,
    //         ),
    //         child: CalendarTodoContent(
    //           height: height,
    //           width: width,
    //           backgroundColor: transparent,
    //           name: todo.name,
    //           color: todo.color,
    //         ),
    //       );

    return CalendarTodoContent(
      height: height,
      width: width,
      backgroundColor: todo.color.withOpacity(
        AppOpacity.disabled,
      ),
      name: todo.name,
      color: todo.color,
    );
  }
}
