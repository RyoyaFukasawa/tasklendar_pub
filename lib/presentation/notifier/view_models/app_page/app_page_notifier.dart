// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';

part 'app_page_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class AppPageNotifier extends _$AppPageNotifier {
  AppPageNotifier();

  @override
  AppPageState build() {
    return AppPageState(
      appBarTitle: now.monthFormat(),
    );
  }

  void updateState(AppPageState value) {
    state = value;
  }

  void updateAppBarTitle(String value) {
    state = state.copyWith(
      appBarTitle: value,
    );
  }

  void updateTitleColor(Color value) {
    state = state.copyWith(
      titleColor: value,
    );
  }
}
