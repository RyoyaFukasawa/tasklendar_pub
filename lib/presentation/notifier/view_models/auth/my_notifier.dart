// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_notifier.g.dart';

@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  bool build() {
    return false;
  }

  void update(bool value) {
    state = value;
  }
}
