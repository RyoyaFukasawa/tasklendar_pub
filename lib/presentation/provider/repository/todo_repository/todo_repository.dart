// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/repository/todo_repository_impl.dart';
import 'package:tasklendar/domain/repository/todo_repository.dart';
import 'package:tasklendar/presentation/provider/datasources/todo_datasource.dart/todo_datasource.dart';
import 'package:tasklendar/presentation/provider/factory/todo_factory/todo_factory.dart';

part 'todo_repository.g.dart';

@riverpod
TodoRepository todoRepository(
  TodoRepositoryRef ref,
) {
  return TodoRepositoryImpl(
    todoDataSource: ref.read(todoDataSourceProvider),
    todoFactory: ref.read(todoFactoryProvider),
  );
}
