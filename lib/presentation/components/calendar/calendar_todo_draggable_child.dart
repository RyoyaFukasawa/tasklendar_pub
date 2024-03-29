// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_content.dart';
import 'package:tasklendar/presentation/notifier/global_vars/calendar_todo_draggable/todo_draggable_id_notifier.dart';

class CalendarTodoDraggableChild extends HookConsumerWidget {
  const CalendarTodoDraggableChild({
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
    final isDraggableId = ref.watch(todoDraggableIdNotifierProvider);
    return CalendarTodoContent(
      height: height,
      width: width,
      backgroundColor: isDraggableId == todo.id
          ? todo.color.withOpacity(
              AppOpacity.disabled,
            )
          : todo.color,
      name: todo.name,
      color: todo.color,
    );
  }
}
