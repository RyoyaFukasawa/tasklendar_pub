// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/repository/todo_repository.dart';
import 'package:tasklendar/domain/usecases/todo/get_todos_usecase.dart';

class GetTodosUseCaseImpl implements GetTodosUseCase {
  GetTodosUseCaseImpl({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  final TodoRepository _todoRepository;

  @override
  Future<List<TodoEntity>> execute() async {
    try {
      return await _todoRepository.fetchAllTodos();
    } catch (e) {
      rethrow;
    }
  }
}
