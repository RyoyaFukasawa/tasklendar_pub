// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> fetchAllTodos();
  Future<TodoEntity> fetchTodoById(String id);
  Future<void> insertTodo(TodoEntity todoEntity);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> updateTodos(List<TodoEntity?> todos);
  Future<void> deleteTodo(TodoEntity todo);
}
