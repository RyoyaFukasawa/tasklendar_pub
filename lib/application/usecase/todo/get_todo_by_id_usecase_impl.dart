// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/repository/todo_repository.dart';
import 'package:tasklendar/domain/usecases/todo/get_todo_by_id_usecase.dart';

class GetTodoByIdUseCaseImpl implements GetTodoByIdUseCase {
  GetTodoByIdUseCaseImpl({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<TodoEntity> execute(String id) {
    return _todoRepository.fetchTodoById(id);
  }
}
