// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/presentation/components/calendar/calendar_grid.dart';
import 'package:tasklendar/presentation/notifier/global_vars/current_month/current_month_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/calendar/calendar_notifier.dart';
import 'package:tasklendar/presentation/state/calendar_page/calendar_page_state.dart';

final calendarPageControllerProvider = StateProvider<PageController>(
  (ref) => PageController(
    initialPage: ref.watch(calendarPageNotifierProvider).pageNumber,
  ),
);

class CalendarPage extends HookConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CalendarPageNotifier calendarNotifier =
        ref.read(calendarPageNotifierProvider.notifier);
    final AppPageNotifier appPageNotifier =
        ref.read(appPageNotifierProvider.notifier);
    final CurrentMonthNotifier currentMonthNotifier =
        ref.read(currentMonthNotifierProvider.notifier);

    final CalendarPageState state = ref.watch(calendarPageNotifierProvider);
    final PageController controller = ref.watch(calendarPageControllerProvider);

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              final DateTime newCurrentMonth = DateTime(
                now.year,
                now.month - (state.pageController.initialPage - index),
              );
              currentMonthNotifier.updateCurrentMonth(newCurrentMonth);
              appPageNotifier.updateAppBarTitle(newCurrentMonth.monthFormat());
              calendarNotifier.updatePageNumber(index);
            },
            itemBuilder: (context, index) {
              return CalendarGrid(
                pageNumber: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
