import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/store/data_store.dart';

class RoutineRepository {
  RoutineRepository({
    required DataStore dataStore,
    required FirebaseFirestore firebaseFirestore,
  })  : _dataStore = dataStore,
        _firebaseFirestore = firebaseFirestore;

  // Store //
  final DataStore _dataStore;
  final FirebaseFirestore _firebaseFirestore;

  // Getter //
  CollectionReference get _collectionReference => _firebaseFirestore
      .collection('users')
      .doc(_dataStore.loggedInUser.value?.uid)
      .collection('routines');

  // Stream<List<TodoModel>> todoStream() {
  //   return _collectionReference
  //       .orderBy('is_pinned', descending: true)
  //       .orderBy('is_done')
  //       .orderBy('priority')
  //       .snapshots()
  //       .map(
  //         (snapshot) => snapshot.docs
  //             .map(
  //               (doc) => TodoModel(
  //                 id: doc.id,
  //                 title: doc['title'],
  //                 isDone: doc['is_done'],
  //                 isPinned: doc['is_pinned'],
  //                 date: DateTime.parse(doc['date'].toDate().toString()),
  //                 priority: doc['priority'],
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

  Future<void> addRoutine({
    required String title,
    required String period,
    required DateTime startDate,
    required DateTime endDate,
    required List dayOfWeek,
    required int interval,
    required bool isInfinite,
  }) async {
    try {
      await _collectionReference.add({
        'title': title,
        'period': period,
        'start_date': startDate,
        'end_date': endDate,
        'day_of_week': dayOfWeek,
        'interval': interval,
        'is_infinite': isInfinite,
      });
    } catch (e) {
      print('addRoutine failed: $e');
    }
  }

  // Future<void> updateTodo({
  //   required String id,
  //   required String title,
  //   required bool isDone,
  //   required bool isPinned,
  //   required DateTime date,
  //   required int priority,
  // }) async {
  //   try {
  //     await _collectionReference.doc(id).update({
  //       'title': title,
  //       'is_done': isDone,
  //       'is_pinned': isPinned,
  //       'date': date,
  //       'priority': priority,
  //     });
  //   } catch (e) {
  //     print('updateTodo failed: $e');
  //   }
  // }

  // Future<TodoModel?> getTodo({
  //   required String id,
  // }) async {
  //   try {
  //     final DocumentSnapshot<Object?> documentSnapshot =
  //         await _collectionReference.doc(id).get();
  //     final Map<String, dynamic> data =
  //         documentSnapshot.data() as Map<String, dynamic>;
  //     return TodoModel(
  //       id: id,
  //       title: data['title'],
  //       isDone: data['is_done'],
  //       isPinned: data['is_pinned'],
  //       date: DateTime.parse(data['date'].toDate().toString()),
  //       priority: data['priority'],
  //     );
  //   } catch (e) {
  //     print('getTodo failed: $e');
  //     return null;
  //   }
  // }

  // Future<void> deleteTodo({
  //   required String id,
  // }) async {
  //   try {
  //     await _collectionReference.doc(id).delete();
  //   } catch (e) {
  //     print('deleteTodo failed: $e');
  //   }
  // }

  // Future<void> toggleIsDone({
  //   required String id,
  //   required bool isDone,
  // }) async {
  //   try {
  //     await _collectionReference.doc(id).update({
  //       'is_done': isDone,
  //     });
  //   } catch (e) {
  //     print('toggleIsDone failed: $e');
  //   }
  // }

  // Future<void> toggleIsPinned({
  //   required String id,
  //   required bool isPinned,
  // }) async {
  //   try {
  //     await _collectionReference.doc(id).update({
  //       'is_pinned': isPinned,
  //     });
  //   } catch (e) {
  //     print('toggleIsPinned failed: $e');
  //   }
  // }

  // Future<void> updateTodosPriority(List<TodoModel> tasks) async {
  //   try {
  //     final WriteBatch batch = _firebaseFirestore.batch();
  //     for (final task in tasks) {
  //       batch.update(_collectionReference.doc(task.id),
  //           {'priority': tasks.indexOf(task)});
  //     }
  //     await batch.commit();
  //   } catch (e) {
  //     print('updatePriority failed: $e');
  //   }
  // }

  // Future<void> deleteAll() async {
  //   try {
  //     await _collectionReference.get().then((snapshot) {
  //       for (DocumentSnapshot doc in snapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     });
  //   } catch (e) {
  //     print('deleteAll failed: $e');
  //   }
  // }
}
