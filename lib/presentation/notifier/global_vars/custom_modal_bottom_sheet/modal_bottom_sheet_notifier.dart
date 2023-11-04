// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/presentation/state/custom_modal_bottom_sheet/modal_bottom_sheet_state.dart';

part 'modal_bottom_sheet_notifier.g.dart';

@Riverpod(keepAlive: true)
class ModalBottomSheetNotifier extends _$ModalBottomSheetNotifier {
  @override
  Map<Key, ModalBottomSheetState> build() {
    return {};
  }

  void updateState(Key key, ModalBottomSheetState newState) {
    state[key] = newState;
    // すべてのstateを更新するためにstateを更新する
    state = {...state};
  }

  ModalBottomSheetState? getState(Key key) {
    return state[key];
  }
}
