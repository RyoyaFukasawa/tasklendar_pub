// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/datasources/todo/todo_datasource.dart';
import 'package:tasklendar/data/datasources/todo/todo_datasource_impl.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';

part 'todo_datasource.g.dart';

@riverpod
TodoDataSource todoDataSource(
  TodoDataSourceRef ref,
) {
  return TodoDataSourceImpl(
    loggedInUserId: ref.read(userNotifierProvider).id,
  );
}
