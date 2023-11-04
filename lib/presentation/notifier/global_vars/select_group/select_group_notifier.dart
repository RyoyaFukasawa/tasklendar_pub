// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';

part 'select_group_notifier.g.dart';

@riverpod
class SelectGroupNotifier extends _$SelectGroupNotifier {
  GroupEntity? build() {
    return null;
  }

  void updateState(GroupEntity? groupEntity) {
    state = groupEntity;
  }
}
