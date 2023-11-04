// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_group_state.freezed.dart';

@freezed
abstract class AddGroupState with _$AddGroupState {
  const factory AddGroupState({
    required String name,
    required String emoji,
    required Color color,
    required GlobalKey<FormState> formKey,
  }) = _AddGroupState;
}
