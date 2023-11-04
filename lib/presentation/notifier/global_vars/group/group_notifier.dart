// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';

part 'group_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class GroupNotifier extends _$GroupNotifier {
  @override
  List<GroupEntity?> build() {
    return [
      GroupEntity(
        id: '1',
        name: 'test',
        emoji: '🍙',
        color: Colors.red,
        createdAt: now,
        updatedAt: now,
        todos: [],
        order: 1,
      ),
      GroupEntity(
        id: '2',
        name: 'test',
        emoji: '😀',
        color: Colors.green,
        createdAt: now,
        updatedAt: now,
        todos: [],
        order: 2,
      ),
      GroupEntity(
        id: '3',
        name: 'test',
        emoji: '🐔',
        color: Colors.blue,
        createdAt: now,
        updatedAt: now,
        todos: [],
        order: 3,
      ),
    ];
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
