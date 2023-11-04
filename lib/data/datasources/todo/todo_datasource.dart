// Project imports:
import 'package:tasklendar/data/models/todo_model.dart';

abstract class TodoDataSource {
  Future<List<TodoModel>> fetchAllTodos();
  Future<TodoModel> fetchTodoById(String id);
  Future<void> updateTodo(
    String id, {
    String? name,
    DateTime? date,
    int? duration,
    bool? isDone,
    String? groupId,
    int? monthCellIndex,
  });
}
