// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> fetchAllTodos();
  Future<TodoEntity> fetchTodoById(String id);
  Future<void> insertTodo();
  Future<void> updateTodo(
    String id, {
    String? name,
    DateTime? date,
    int? duration,
    bool? isDone,
    String? groupId,
    int? monthCellIndex,
  });
  Future<void> deleteTodo();
}
