// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/presentation/state/select_dates/select_dates_state.dart';

part 'select_dates_notifier.g.dart';

@riverpod
class SelectDatesNotifier extends _$SelectDatesNotifier {
  @override
  SelectDatesState build() {
    return const SelectDatesState(
      startDate: null,
      endDate: null,
      duration: 1,
    );
  }

  void updateState(SelectDatesState newState) {
    state = newState;
  }

  void autoCalculateDuration() {
    if (state.endDate == null || state.startDate == null) {
      state = state.copyWith(
        duration: 1,
      );
      return;
    }

    state = state.copyWith(
      duration: state.endDate!.difference(state.startDate!).inDays + 1,
    );
  }

  int calculateDuration({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return endDate.difference(startDate).inDays + 1;
  }
}
