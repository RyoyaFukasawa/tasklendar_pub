// // Flutter imports:
// import 'package:flutter/services.dart';

// // Package imports:
// import 'package:get/get.dart';

// // Project imports:
// import 'package:tasklendar/core/logs/log.dart';
// import 'package:tasklendar/domain/entities/group_entity.dart';
// import 'package:tasklendar/domain/entities/todo_entity.dart';
// import 'package:tasklendar/domain/entities/user_entity.dart';

// class GlobalState {
//   // Rx //
//   final Rx<UserEntity?> loggedInUser = Rx<UserEntity?>(null);
//   final RxList<TodoEntity> allTodos = <TodoEntity>[].obs;
//   final RxBool isLoading = false.obs;

//   // consistence //
//   final DateTime now = DateTime.now();

//   // allTodos methods //
//   TodoEntity getTodoById(String id) {
//     return allTodos.firstWhere((todo) => todo.id == id);
//   }

//   void addTodoToList(TodoEntity todo) {
//     allTodos.add(todo);
//   }

//   void removeTodoFromList(String id) {
//     TodoEntity? removedTodo;
//     allTodos.removeWhere((todo) {
//       if (todo.id == id) {
//         removedTodo = todo;
//         return true;
//       } else {
//         return false;
//       }
//     });

//     Log.debug(removedTodo.toString());
//   }

//   Future<void> updateTodoInList(
//     String id, {
//     String? name,
//     DateTime? date,
//     int? duration,
//     Color? color,
//     bool? isDone,
//     int? monthCellIndex,
//     GroupEntity? group,
//   }) async {
//     final int index = allTodos.indexWhere((element) => element.id == id);
//     allTodos[index] = allTodos[index].copyWith(
//       name: name,
//       date: date,
//       duration: duration,
//       color: color,
//       isDone: isDone,
//       monthCellIndex: monthCellIndex,
//       group: group,
//       updatedAt: DateTime.now(),
//     );

//     // Log.debug(allTodos[index].toString());
//   }

//   void updateTodoInListById(String id) {
//     final index = allTodos.indexWhere((element) => element.id == id);
//     allTodos[index] = getTodoById(id);
//   }

//   void updateAllTodos(List<TodoEntity> allTodos) {
//     allTodos = allTodos.obs;
//   }

//   void clearAllTodos() {
//     allTodos.clear();
//   }

//   Future<void> sortTodos() async {
//     final List<TodoEntity> entriesList = allTodos.toList();

//     // 2. DateTimeで昇順にソート
//     // entriesList.sort((a, b) => a.date.compareTo(b.date));
//     entriesList.sort((a, b) {
//       final dateComparison = a.date.compareTo(b.date);
//       if (dateComparison == 0) {
//         // a.dateとb.dateが同じ場合、updatedAtで比較
//         return b.updatedAt.compareTo(a.updatedAt);
//       } else {
//         return dateComparison;
//       }
//     });

//     // 新しいMapをRxにセット
//     allTodos.value = entriesList;
//   }

//   // loggedInUser methods //
//   void updateLoggedInUser(UserEntity? user) {
//     loggedInUser.value = user;
//   }

//   void clearLoggedInUser() {
//     loggedInUser.value = null;
//   }
// }
