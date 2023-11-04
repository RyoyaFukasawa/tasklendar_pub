// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/presentation/state/add_group/add_group_state.dart';

part 'add_group_notifier.g.dart';

@riverpod
class AddGroupNotifier extends _$AddGroupNotifier {
  @override
  AddGroupState build() {
    return AddGroupState(
      name: '',
      emoji: '',
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      formKey: GlobalKey<FormState>(),
    );
  }

  void updateState(AddGroupState value) {
    state = value;
  }

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateEmoji(String value) {
    state = state.copyWith(emoji: value);
  }

  void updateColor(Color value) {
    state = state.copyWith(color: value);
  }
}
