// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/state/group_detail/group_detail_state.dart';

part 'group_detail_notifier.g.dart';

@riverpod
class GroupDetailNotifier extends _$GroupDetailNotifier {
  @override
  GroupDetailState build() {
    return const GroupDetailState(todos: []);
  }

  void updateState(List<TodoEntity?> todos) {
    state = state.copyWith(todos: todos);
  }

  void removeTodo(TodoEntity todo) {
    state = state.copyWith(
      todos: state.todos.where((element) => element != todo).toList(),
    );
    final todoNotifier = ref.read(todoNotifierProvider.notifier);
    todoNotifier.removeTodo(todo);
  }
}
