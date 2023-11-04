// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

abstract class GetTodosUseCase {
  Future<List<TodoEntity>> execute();
}
