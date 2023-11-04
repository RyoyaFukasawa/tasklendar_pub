// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_dates_state.freezed.dart';

@freezed
abstract class SelectDatesState with _$SelectDatesState {
  const factory SelectDatesState({
    required DateTime? startDate,
    required DateTime? endDate,
    required int duration,
  }) = _SelectDatesState;
}
