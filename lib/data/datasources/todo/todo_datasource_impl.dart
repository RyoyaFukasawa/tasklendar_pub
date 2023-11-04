// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:tasklendar/data/datasources/todo/todo_datasource.dart';
import 'package:tasklendar/data/models/todo_model.dart';

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
      final DocumentSnapshot<Map<String, dynamic>> res =
          await _todoCollection.doc(id).get();

      if (res.data() == null) {
        throw Exception('Todo not found');
      }

      final TodoModel todo = TodoModel.fromJson(res.data()!);

      await _todoCollection.doc(id).update(
        {
          'name': name ?? todo.name,
          'date': date ?? todo.date,
          'duration': duration ?? todo.duration,
          'isDone': isDone ?? todo.isDone,
          'groupId': groupId ?? todo.groupId,
          'updatedAt': DateTime.now(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
