// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_page_state.freezed.dart';

@freezed
abstract class CalendarPageState with _$CalendarPageState {
  const factory CalendarPageState({
    required PageController pageController,
    required int initialPage,
    required int pageNumber,
    required double appBarHeight,
    required double dayOfWeekHeight,
    required double linerIndicatorHeight,
    required double monthCellDayHeight,
    required int todoLength,
    required DateTime targetDay,
  }) = _CalendarPageState;
}
