// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasklendar/core/enums/snack_bar_type.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';

part 'snack_bar_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class SnackBarNotifier extends _$SnackBarNotifier {
  @override
  SnackBarState build() {
    return const SnackBarState(
      isShown: false,
      message: '',
      type: SnackBarType.success,
    );
  }

  void updateSnackBarStatus(SnackBarState value) {
    state = value;
  }
}
