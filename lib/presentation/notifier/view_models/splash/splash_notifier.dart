// Package imports:
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';

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
    try {
      UserEntity? user = await authRepository.fetchUser();

      user ??= await authRepository.signInAnonymously();

      Log.debug(user.toString());

      userNotifier.updateUser(
        user,
      );

      FlutterNativeSplash.remove();
    } catch (e) {
      Log.error(e.toString());
    }
  }

  void updateState(bool value) {
    state = value;
  }
}
