// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/data/datasources/auth/auth_datasource.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/provider/datasources/auth_datasource.dart/auth_datasource.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';
import 'package:tasklendar/presentation/state/user/user_state.dart';

part 'my_page_notifier.g.dart';

@riverpod
class MyPageNotifier extends _$MyPageNotifier {
  @override
  bool build() {
    return true;
  }

  Future<void> signOut() async {
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    try {
      await authRepository.signOut();
      userNotifier.setDefaultUser();
    } catch (e) {
      rethrow;
    }
  }
}
