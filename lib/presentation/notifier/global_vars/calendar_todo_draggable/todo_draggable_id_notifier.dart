// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_draggable_id_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class TodoDraggableIdNotifier extends _$TodoDraggableIdNotifier {
  @override
  String build() {
    return '';
  }

  void updateTodoDraggableId(String value) {
    state = value;
  }
}
