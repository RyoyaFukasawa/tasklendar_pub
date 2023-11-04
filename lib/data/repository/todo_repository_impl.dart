// Project imports:
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/data/datasources/todo/todo_datasource.dart';
import 'package:tasklendar/data/models/todo_model.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/factory/todo_factory.dart';
import 'package:tasklendar/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({
    required TodoDataSource todoDataSource,
    required TodoFactory todoFactory,
  })  : _todoDataSource = todoDataSource,
        _todoFactory = todoFactory;

  final TodoDataSource _todoDataSource;
  final TodoFactory _todoFactory;

  @override
  Future<void> deleteTodo() {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<List<TodoEntity>> fetchAllTodos() async {
    try {
      final List<TodoModel> res = await _todoDataSource.fetchAllTodos();

      Log.debug(res.toString());

      final List<TodoEntity> todoList = [];

      for (var e in res) {
        final todoEntity = await _todoFactory.createTodo(
          id: e.id,
          name: e.name,
          date: e.date,
          duration: e.duration,
          color: e.color,
          isDone: e.isDone,
          groupId: e.groupId,
          updatedAt: e.updatedAt,
        );
        todoList.add(todoEntity);
      }

      return todoList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TodoEntity> fetchTodoById(String id) async {
    try {
      final TodoModel res = await _todoDataSource.fetchTodoById(id);

      Log.debug(res.toString());

      final TodoEntity todo = await _todoFactory.createTodo(
        id: res.id,
        name: res.name,
        date: res.date,
        duration: res.duration,
        color: res.color,
        isDone: res.isDone,
        groupId: res.groupId,
        updatedAt: res.updatedAt,
      );

      return todo;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertTodo() {
    // TODO: implement insertTodo
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(
    String id, {
    String? name,
    DateTime? date,
    int? duration,
    bool? isDone,
    String? groupId,
    int? monthCellIndex,
  }) async {
    try {
      await _todoDataSource.updateTodo(
        id,
        name: name,
        date: date,
        duration: duration,
        isDone: isDone,
        groupId: groupId,
        monthCellIndex: monthCellIndex,
      );
    } catch (e) {
      rethrow;
    }
  }
}
