// Project imports:
import 'package:tasklendar/domain/repository/todo_repository.dart';
import 'package:tasklendar/domain/usecases/todo/update_todo_usecase.dart';

class UpdateTodoUseCaseImpl implements UpdateTodoUseCase {
  UpdateTodoUseCaseImpl({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  final TodoRepository _todoRepository;

  @override
  Future<void> execute(
    String id, {
    String? name,
    DateTime? date,
    int? duration,
    bool? isDone,
    String? groupId,
    int? monthCellIndex,
  }) async {
    await _todoRepository.updateTodo(
      id,
      name: name,
      date: date,
      duration: duration,
      isDone: isDone,
      groupId: groupId,
      monthCellIndex: monthCellIndex,
    );
  }
}
