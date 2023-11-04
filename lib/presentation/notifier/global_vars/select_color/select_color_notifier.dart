// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_color_notifier.g.dart';

@riverpod
class SelectColorNotifier extends _$SelectColorNotifier {
  @override
  Color build() {
    return const Color(0xFF000000);
  }

  void updateState(Color newState) {
    state = newState;
  }
}
