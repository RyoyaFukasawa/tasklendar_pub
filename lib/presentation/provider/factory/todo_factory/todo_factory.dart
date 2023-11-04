// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/factory/todo_factory_impl.dart';
import 'package:tasklendar/domain/factory/todo_factory.dart';

part 'todo_factory.g.dart';

@riverpod
TodoFactory todoFactory(
  TodoFactoryRef ref,
) {
  return TodoFactoryImpl();
}
