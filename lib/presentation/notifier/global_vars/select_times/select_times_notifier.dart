// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_times_notifier.g.dart';

@riverpod
class SelectTimesNotifier extends _$SelectTimesNotifier {
  @override
  int build() {
    return 1;
  }

  void updateState(int time) {
    state = time;
  }
}
