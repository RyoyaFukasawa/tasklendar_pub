// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_draggable_child.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_feed_back.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_todo_when_dragging.dart';
import 'package:tasklendar/presentation/notifier/global_vars/calendar_todo_draggable/todo_draggable_id_notifier.dart';

class CalendarDraggableTodo extends HookConsumerWidget {
  const CalendarDraggableTodo({
    super.key,
    required this.todo,
    required this.todoHeight,
    required this.childWidth,
    required this.draggingWidth,
    required this.feedbackWidth,
  });

  final TodoEntity todo;
  final double todoHeight;
  final double childWidth;
  final double draggingWidth;
  final double feedbackWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoDraggableNotifier =
        ref.read(todoDraggableIdNotifierProvider.notifier);

    return LongPressDraggable(
      onDragStarted: () {
        todoDraggableNotifier.updateTodoDraggableId(todo.id);
      },
      onDragCompleted: () {
        todoDraggableNotifier.updateTodoDraggableId('');
      },
      data: todo,
      feedback: CalendarTodoFeedBack(
        height: todoHeight,
        width: feedbackWidth,
        todo: todo,
      ),
      childWhenDragging: CalendarTodoWhenDragging(
        todo: todo,
        height: todoHeight,
        width: childWidth,
      ),
      child: CalendarTodoDraggableChild(
        todo: todo,
        height: todoHeight,
        width: childWidth,
      ),
    );
  }
}
