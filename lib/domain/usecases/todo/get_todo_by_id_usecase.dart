// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class GetTodoByIdUseCase {
  Future<TodoEntity> execute(String id);
}
