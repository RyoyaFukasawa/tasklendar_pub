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
        final TodoEntity todoEntity = await _todoFactory.createTodo(
          id: e.id,
          name: e.name,
          date: e.date,
          duration: e.duration,
          times: e.times,
          currentTimes: e.currentTimes,
          color: e.color,
          isDone: e.isDone,
          monthCellIndex: e.monthCellIndex,
          groupId: e.groupId,
          updatedAt: e.updatedAt,
          createdAt: e.createdAt,
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
        times: res.times,
        currentTimes: res.currentTimes,
        color: res.color,
        isDone: res.isDone,
        monthCellIndex: res.monthCellIndex,
        groupId: res.groupId,
        updatedAt: res.updatedAt,
        createdAt: res.createdAt,
      );

      return todo;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertTodo(TodoEntity todo) async {
    try {
      await _todoDataSource.insertTodo(
        todo,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    try {
      await _todoDataSource.updateTodo(
        todo,
      );
    } catch (e) {
      rethrow;
    }
  }
}
