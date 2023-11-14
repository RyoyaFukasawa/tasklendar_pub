// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class TodoFactory {
  Future<TodoEntity> createTodo({
    required String id,
    required String name,
    required DateTime? date,
    required int duration,
    required int times,
    required int currentTimes,
    required int color,
    required bool isDone,
    required int monthCellIndex,
    required String? groupId,
    required DateTime createdAt,
    required DateTime updatedAt,
  });
}
