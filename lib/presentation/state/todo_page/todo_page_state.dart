// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

part 'todo_page_state.freezed.dart';

@freezed
abstract class TodoPageState with _$TodoPageState {
  const factory TodoPageState({
    required List<TodoEntity?> todos,
  }) = _TodoPageState;
}
