import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/modules/todo/components/todo_tile.dart';
import 'package:tasklendar/app/modules/todo/controllers/todo_controller.dart';

class TodoList extends GetView<TodoController> {
  TodoList({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
        child: Stack(
          children: [
            Obx(() {
              final todos = controller.getTodosForDate(date);
              if (todos == null) {
                return Container();
              }
              return ReorderableListView.builder(
                key: UniqueKey(),
                itemCount: todos.length,
                itemBuilder: (_, index) => TodoTile(
                  todo: todos[index],
                  key: Key('$index'),
                ),
                onReorder: (int oldIndex, int newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final TodoModel task = todos.removeAt(oldIndex);
                  todos.insert(newIndex, task);
                  controller.updateTodosPriority(todos);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
