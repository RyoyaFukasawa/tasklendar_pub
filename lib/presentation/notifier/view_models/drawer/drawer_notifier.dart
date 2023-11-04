// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/config/constraints/drawer_key.dart';
import 'package:tasklendar/presentation/state/drawer/drawer_state.dart';

part 'drawer_notifier.g.dart';

@Riverpod(keepAlive: true)
class DrawerNotifier extends _$DrawerNotifier {
  @override
  DrawerState build() {
    return DrawerState(
      selectedKey: DrawerKey.get(DrawerKeyType.calendar),
    );
  }

  void updateSelectedKey(Key key) {
    state = state.copyWith(
      selectedKey: key,
    );
  }
}
