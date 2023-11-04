// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modal_bottom_sheet_state.freezed.dart';

@freezed
abstract class ModalBottomSheetState with _$ModalBottomSheetState {
  const factory ModalBottomSheetState({
    required bool isSave,
  }) = _ModalBottomSheetState;
}
