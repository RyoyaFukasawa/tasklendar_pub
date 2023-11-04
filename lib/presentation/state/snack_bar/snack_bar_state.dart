// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasklendar/core/enums/snack_bar_type.dart';

part 'snack_bar_state.freezed.dart';

@freezed
abstract class SnackBarState with _$SnackBarState {
  const factory SnackBarState({
    required bool isShown,
    required String message,
    required SnackBarType type,
  }) = _SnackBarState;
}
