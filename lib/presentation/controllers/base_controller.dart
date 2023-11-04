// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:get/get.dart';

// // Project imports:
// import 'package:tasklendar/config/styles/app_borders.dart';
// import 'package:tasklendar/config/styles/app_themes.dart';
// import 'package:tasklendar/config/styles/app_typography.dart';
// import 'package:tasklendar/domain/entities/group_entity.dart';
// import 'package:tasklendar/domain/entities/todo_entity.dart';
// import 'package:tasklendar/domain/entities/user_entity.dart';
// import 'package:tasklendar/presentation/global_state.dart';

// abstract class BaseController extends GetxController {
//   BaseController({
//     required GlobalState globalState,
//   }) : _globalState = globalState;

//   final GlobalState _globalState;

//   UserEntity? get loggedInUser => _globalState.loggedInUser.value;
//   List<TodoEntity> get allTodos => _globalState.allTodos;
//   DateTime get now => _globalState.now;

//   // Todos methods //
//   TodoEntity getTodoById(String id) {
//     return _globalState.getTodoById(id);
//   }

//   void addTodoToList(TodoEntity todo) {
//     _globalState.addTodoToList(todo);
//   }

//   void removeTodoFromList(String id) {
//     _globalState.removeTodoFromList(id);
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
//     _globalState.updateTodoInList(
//       id,
//       name: name,
//       date: date,
//       duration: duration,
//       color: color,
//       isDone: isDone,
//       monthCellIndex: monthCellIndex,
//       group: group,
//     );
//   }

//   void updateTodoInListById(String id) {
//     final TodoEntity todo = getTodoById(id);
//     _globalState.updateTodoInList(
//       id,
//       name: todo.name,
//       date: todo.date,
//       duration: todo.duration,
//       color: todo.color,
//       isDone: todo.isDone,
//       monthCellIndex: todo.monthCellIndex,
//       group: todo.group,
//     );
//   }

//   void updateAllTodos(List<TodoEntity> allTodos) {
//     _globalState.updateAllTodos(allTodos);
//   }

//   void clearAllTodos() {
//     _globalState.clearAllTodos();
//   }

//   Future<void> sortTodos() async {
//     _globalState.sortTodos();
//   }

//   // User methods //
//   void updateLoggedInUser(UserEntity user) {
//     _globalState.updateLoggedInUser(user);
//   }

//   void clearLoggedInUser() {
//     _globalState.clearLoggedInUser();
//   }

//   // final remainingSeconds = 5.obs;
//   // Timer.periodic(const Duration(seconds: 1), (timer) {
//   //   remainingSeconds.value--;
//   //   if (remainingSeconds.value <= 0) {
//   //     timer.cancel();
//   //   }
//   // });

//   // final pro = 0.0.obs;
//   // void startAnimation() {
//   //   Timer.periodic(const Duration(milliseconds: 10), (timer) {
//   //     pro.value += 0.01;
//   //     if (pro.value >= 1.0) {
//   //       timer.cancel();
//   //       pro.value = 0.0;
//   //       startAnimation();
//   //     }
//   //   });
//   // }

//   // startAnimation();

//   void showSnackBar({
//     required BuildContext context,
//     required String message,
//     bool? enableUndo,
//   }) {
//     final snackBar = SnackBar(
//       content: Text(
//         message,
//         style: AppTypography.body,
//       ),
//       duration: const Duration(seconds: 3),
//       action: enableUndo == true
//           ? SnackBarAction(
//               label: 'キャンセル',
//               onPressed: () {
//                 // undoDelete(todo);
//               },
//             )
//           : null,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppBorders.radius),
//       ),
//       backgroundColor: AppTheme.colorScheme.onBackground,
//       elevation: 1,
//       behavior: SnackBarBehavior.floating,
//       dismissDirection: DismissDirection.none,
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   void hideSnackBar(BuildContext context) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   }

//   // void deleteTodo(TodoModel todo, BuildContext context) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content:
//   //           //  Obx(
//   //           //   () =>
//   //           Row(
//   //         children: [
//   //           // Stack(
//   //           //   alignment: Alignment.center,
//   //           //   children: [
//   //           //     CircularProgressIndicator(
//   //           //       strokeWidth: 3,
//   //           //       valueColor: AlwaysStoppedAnimation<Color>(
//   //           //         AppTheme.colorScheme.primary,
//   //           //       ),
//   //           //       value: pro.value,
//   //           //     ),
//   //           //     Text(
//   //           //       '${remainingSeconds.value}',
//   //           //       style: AppTypography.body.copyWith(
//   //           //         color: AppTheme.colorScheme.primary,
//   //           //       ),
//   //           //     ),
//   //           //   ],
//   //           // ),
//   //           // const Gap(15),
//   //           Text(
//   //             '${todo.name}を削除しました。',
//   //             style: AppTypography.body.copyWith(
//   //               color: AppTheme.colorScheme.primary,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //       // ),
//   //       duration: Duration(seconds: 5),
//   //       // Duration(milliseconds: remainingSeconds.value * 1000 - 300),
//   //       action: SnackBarAction(
//   //         label: 'キャンセル',
//   //         onPressed: () {
//   //           undoDelete(todo);
//   //         },
//   //       ),
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(10),
//   //       ),
//   //       backgroundColor: AppTheme.colorScheme.onPrimary,
//   //       elevation: 1,
//   //       behavior: SnackBarBehavior.floating,
//   //     ),
//   //   );

//   //   tempTodo.add(todo);
//   //   // _dataStore.removeTodosByDate(todo);
//   //   _dataStore.removeAllTodos(todo);

//   //   Future.delayed(const Duration(milliseconds: 5500), () {
//   //     if (tempTodo.contains(todo)) {
//   //       tempTodo.remove(todo);
//   //       _todoRepository.deleteTodo(
//   //         id: todo.id,
//   //       );
//   //     }
//   //   });
//   // }

//   // void undoDelete(TodoModel todo) {
//   //   if (tempTodo.contains(todo)) {
//   //     tempTodo.remove(todo);
//   //     _updateTodoData(todo);
//   //   }
//   // }
// }
