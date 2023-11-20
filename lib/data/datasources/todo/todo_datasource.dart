// Project imports:
import 'package:tasklendar/data/models/todo_model.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class TodoDataSource {
  Future<List<TodoModel>> fetchAllTodos();
  Future<TodoModel> fetchTodoById(String id);
  Future<void> insertTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);
}
