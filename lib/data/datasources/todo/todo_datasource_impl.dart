// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:tasklendar/data/datasources/todo/todo_datasource.dart';
import 'package:tasklendar/data/models/todo_model.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

class TodoDataSourceImpl implements TodoDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TodoDataSourceImpl({
    required String loggedInUserId,
  }) : _loggedInUserId = loggedInUserId;

  final String _loggedInUserId;

  // Getter //
  CollectionReference<Map<String, dynamic>> get _todoCollection =>
      _firestore.collection('users').doc(_loggedInUserId).collection('todos');

  @override
  Future<List<TodoModel>> fetchAllTodos() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> res =
          await _todoCollection.get();

      return res.docs.map(
        (QueryDocumentSnapshot<Map<String, dynamic>> e) {
          return TodoModel.fromJson(e.data());
        },
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TodoModel> fetchTodoById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> res =
          await _todoCollection.doc(id).get();

      if (res.data() == null) {
        throw Exception('Todo not found');
      }

      return TodoModel.fromJson(res.data()!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final TodoModel todoModel = TodoModel.fromEntity(todo);
    try {
      final DocumentSnapshot<Map<String, dynamic>> res =
          await _todoCollection.doc(todoModel.id).get();

      if (res.data() == null) {
        throw Exception('Todo not found');
      }

      final TodoModel fetchTodo = TodoModel.fromJson(res.data()!);

      await _todoCollection.doc(fetchTodo.id).update(
            todoModel.toJson(),
          );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertTodo(TodoEntity todo) async {
    final TodoModel todoModel = TodoModel.fromEntity(todo);
    try {
      await _todoCollection.doc(todo.id).set(todoModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
