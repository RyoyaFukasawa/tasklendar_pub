// Package imports:
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/domain/repository/group_repository.dart';
import 'package:tasklendar/domain/repository/todo_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';
import 'package:tasklendar/presentation/provider/repository/group_repository/group_repository.dart';
import 'package:tasklendar/presentation/provider/repository/todo_repository/todo_repository.dart';

part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  bool build() {
    return false;
  }

  Future initialized() async {
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    final GroupNotifier groupNotifier = ref.read(groupNotifierProvider.notifier);
    try {
      UserEntity? user = await authRepository.fetchUser();

      user ??= await authRepository.signInAnonymously();

      Log.debug(user.toString());

      await userNotifier.updateUser(
        user,
      );

      // userState.idを使っているため、userStateが更新されてからtodoを取得する
      final TodoRepository todoRepository = ref.read(todoRepositoryProvider);

      final List<TodoEntity> todoList = await todoRepository.fetchAllTodos();

      await todoNotifier.updateTodos(todoList);

      final GroupRepository groupRepository = ref.read(groupRepositoryProvider);

      final List<GroupEntity> groupList = await groupRepository.fetchAllGroups();

      await groupNotifier.updateGroups(groupList);

      FlutterNativeSplash.remove();
    } catch (e) {
      Log.error(e.toString());
    }
  }

  void updateState(bool value) {
    state = value;
  }
}
