// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';

part 'group_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class GroupNotifier extends _$GroupNotifier {
  @override
  List<GroupEntity?> build() {
    return [];
  }

  void removeGroup(String id) {
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    state = state.where((element) => element?.id != id).toList();
    todoNotifier.removeTodoByProperty(
      property: 'groupId',
      value: id,
    );
  }

  void removeGroupInList(GroupEntity group) {
    state = state.where((element) => element?.id != group.id).toList();
  }

  Future<void> addGroup(GroupEntity value) async {
    state = [...state, value];
  }

  Future<void> updateGroup(
    GroupEntity value,
  ) async {
    final index = state.indexWhere((element) => element?.id == value.id);
    state[index] = value;

    state = [...state];
  }

  GroupEntity? getGroupById(String id) {
    return state.firstWhere((element) => element?.id == id);
  }

  void sortByOrder() {
    state.sort((a, b) => a!.order!.compareTo(b!.order!));
  }

  void updateGroups(List<GroupEntity?> groups) {
    state = [...groups];

    //TODO ここはバッチ処理にする
  }
}
