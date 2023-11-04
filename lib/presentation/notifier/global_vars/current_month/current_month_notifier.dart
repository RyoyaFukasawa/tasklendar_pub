// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';

part 'current_month_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class CurrentMonthNotifier extends _$CurrentMonthNotifier {
  @override
  DateTime build() {
    return now;
  }

  void updateCurrentMonth(DateTime value) {
    state = value;
  }
}
