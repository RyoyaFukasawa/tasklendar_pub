// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:

part 'todo_entity.freezed.dart';

@freezed
abstract class TodoEntity with _$TodoEntity {
  const factory TodoEntity({
    required String id,
    required String name,
    required DateTime? date,
    required int duration,
    required int times,
    required int currentTimes,
    required Color color,
    required bool isDone,
    required int monthCellIndex,
    required String? groupId,
    required DateTime updatedAt,
    required DateTime createdAt,
  }) = _TodoEntity;
}
