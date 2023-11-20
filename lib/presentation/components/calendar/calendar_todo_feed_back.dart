// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_content.dart';

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
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(5),
      child: CalendarTodoContent(
        height: height,
        width: width,
        backgroundColor: todo.color,
        name: todo.name,
        color: todo.color,
      ),
    );
  }
}
