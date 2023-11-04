// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class TodoFactory {
  Future<TodoEntity> createTodo({
    required String id,
    required String name,
    required DateTime date,
    required int duration,
    required int color,
    required bool isDone,
    String? groupId,
    required DateTime updatedAt,
  });
}
