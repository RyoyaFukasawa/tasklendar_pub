// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/state/todo_page/todo_page_state.dart';

part 'todo_page_notifier.g.dart';

@riverpod
class TodoPageNotifier extends _$TodoPageNotifier {
  @override
  TodoPageState build() {
    return const TodoPageState(todos: []);
  }

  void updateState(List<TodoEntity?> todos) {
    state = state.copyWith(todos: todos);
  }

  Future<void> removeTodo(TodoEntity todo) async {
    state = state.copyWith(
      todos: state.todos.where((element) => element != todo).toList(),
    );
    final todoNotifier = ref.read(todoNotifierProvider.notifier);
    await todoNotifier.removeTodo(todo);
    await todoNotifier.deleteTodo(todo);
  }
}
