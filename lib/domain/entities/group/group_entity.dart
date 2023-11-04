// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

part 'group_entity.freezed.dart';

@freezed
abstract class GroupEntity with _$GroupEntity {
  const factory GroupEntity({
    required String id,
    required String name,
    required String emoji,
    required Color color,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<TodoEntity?> todos,
    int? order, // 0 is the highest, null is the lowest
  }) = _GroupEntity;
}
