// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawer_state.freezed.dart';

@freezed
abstract class DrawerState with _$DrawerState {
  const factory DrawerState({
    required Key selectedKey,
  }) = _DrawerState;
}
