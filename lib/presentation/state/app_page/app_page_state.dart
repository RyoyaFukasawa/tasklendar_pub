// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_page_state.freezed.dart';

@freezed
abstract class AppPageState with _$AppPageState {
  const factory AppPageState({
    required String appBarTitle,
    Color? titleColor,
    BuildContext? context,
    String? groupId, // customFloatingで使う
    Function()? onTitlePressed,
    DateTime? selectedDate, // customFloatingで使う
  }) = _AppPageState;
}
