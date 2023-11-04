// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

part 'group_detail_state.freezed.dart';

@freezed
abstract class GroupDetailState with _$GroupDetailState {
  const factory GroupDetailState({
    required List<TodoEntity?> todos,
  }) = _GroupDetailState;
}
