// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/presentation/state/calendar_page/calendar_page_state.dart';

part 'calendar_notifier.g.dart';

@Riverpod(keepAlive: true)
class CalendarPageNotifier extends _$CalendarPageNotifier {
  CalendarPageNotifier();

  final int initialPage = 5000;
  final double dayOfWeekHeight = 26;
  final double linerIndicatorHeight = 4;
  final double monthCellDayHeight = 23;
  final double appBarHeight = kToolbarHeight;
  final double monthCellBorder = 0.5;
  final int todoLength = 5;

  @override
  CalendarPageState build() {
    return CalendarPageState(
      pageController: PageController(
        initialPage: initialPage,
      ),
      initialPage: initialPage,
      pageNumber: initialPage,
      appBarHeight: appBarHeight,
      dayOfWeekHeight: dayOfWeekHeight,
      linerIndicatorHeight: linerIndicatorHeight,
      monthCellDayHeight: monthCellDayHeight,
      todoLength: todoLength,
      targetDay: DateTime.now(),
    );
  }

  String getWeekdayName(
    int weekday,
    BuildContext context,
  ) {
    final List<String> weekdayName = [
      AppLocalizations.of(context)!.day_of_week_sun,
      AppLocalizations.of(context)!.day_of_week_mon,
      AppLocalizations.of(context)!.day_of_week_tue,
      AppLocalizations.of(context)!.day_of_week_wed,
      AppLocalizations.of(context)!.day_of_week_thu,
      AppLocalizations.of(context)!.day_of_week_fri,
      AppLocalizations.of(context)!.day_of_week_sat
    ];
    return weekdayName[weekday];
  }

  Future<void> updateTargetDay(DateTime value) async {
    state = state.copyWith(targetDay: value);
  }

  void updatePageNumber(int value) {
    state = state.copyWith(pageNumber: value);
  }

  // void updatePageController(PageController value) {
  //   state = state.copyWith(pageController: value);
  // }

  void updateInitialPage(int value) {
    state = state.copyWith(initialPage: value);
  }

  bool isDateInSixWeeks(
    DateTime currentMonth,
    DateTime date,
    int firstDayOfWeek,
  ) {
    int firstWeekday = currentMonth.firstDayOfMonth().weekday;

    int totalDays = 42;

    // 6週間で1~42日までだから
    DateTime startDate = DateTime(
      currentMonth.year,
      currentMonth.month,
      1 - firstWeekday + (firstDayOfWeek % 7),
    );
    DateTime endDate = DateTime(
      currentMonth.year,
      currentMonth.month,
      totalDays - firstWeekday + (firstDayOfWeek % 7),
    );

    return date.isAfter(startDate) && date.isBefore(endDate) ||
        date == startDate ||
        date == endDate;
  }

  double calculateYPosition({
    required int day,
    required int firstWeekday,
    required double gridHeight,
    required double monthCellDayHeight,
  }) {
    int row = 0;
    // Calculate the week number
    row = (firstWeekday + day) ~/ 7;
    if (firstWeekday + day < 0) {
      row = -1;
    }
    return (row * gridHeight / 6) + monthCellDayHeight;
  }

  double calculateXPosition({
    required int weekday,
    required int startWeekday,
    required screenWidth,
  }) {
    double gridWidth = screenWidth;
    int offset = (weekday % 7) - (startWeekday % 7);
    return offset * (gridWidth / 7);
  }

  double calculateWidth({
    required DateTime from,
    required DateTime to,
    required screenWidth,
  }) {
    int days = to.difference(from).inDays + 1;
    return days * screenWidth / 7 - 3;
  }
}
