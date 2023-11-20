// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasklendar/core/logs/log.dart';

// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/repository/group_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/provider/repository/group_repository/group_repository.dart';

part 'group_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class GroupNotifier extends _$GroupNotifier {
  @override
  List<GroupEntity?> build() {
    return [];
  }

  Future<void> removeGroup(GroupEntity group) async {
    final String id = group.id;
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    state = state.where((element) => element?.id != id).toList();
    todoNotifier.removeTodoByProperty(
      property: 'groupId',
      value: id,
    );
    final GroupRepository groupRepository = ref.read(groupRepositoryProvider);
    try {
      await groupRepository.deleteGroup(group);
    } catch (e) {
      Log.error(e.toString());
    }
  }

  void removeGroupInList(GroupEntity group) {
    state = state.where((element) => element?.id != group.id).toList();
  }

  Future<void> updateGroups(List<GroupEntity?> groups) async {
    state = [...groups];
  }

  Future<void> addGroup(GroupEntity group) async {
    state = [...state, group];
    final GroupRepository groupRepository = ref.read(groupRepositoryProvider);
    try {
      await groupRepository.insertGroup(
        group,
      );
    } catch (e) {
      Log.error(e.toString());
    }
  }

  Future<void> updateGroup(
    GroupEntity group,
  ) async {
    final index = state.indexWhere((element) => element?.id == group.id);
    state[index] = group;

    state = [...state];

    final GroupRepository groupRepository = ref.read(groupRepositoryProvider);
    try {
      await groupRepository.updateGroup(
        group,
      );
    } catch (e) {
      Log.error(e.toString());
    }
  }

  GroupEntity? getGroupById(String id) {
    return state.firstWhere((element) => element?.id == id);
  }

  void sortByOrder() {
    state.sort((a, b) => a!.order!.compareTo(b!.order!));
  }
}
