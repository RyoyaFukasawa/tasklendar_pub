// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/domain/repository/user_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';
import 'package:tasklendar/presentation/provider/repository/user_repository/user_repository.dart';
import 'package:tasklendar/presentation/state/change_email/change_email_state.dart';

part 'change_email_notifier.g.dart';

@riverpod
class ChangeEmailNotifier extends _$ChangeEmailNotifier {
  @override
  ChangeEmailState build() {
    return ChangeEmailState(
      formKey: GlobalKey<FormState>(),
      newEmail: '',
      password: '',
    );
  }

  void updateState(ChangeEmailState newState) {
    state = newState;
  }

  Future<void> updateEmail() async {
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    try {
      final UserEntity? user = await authRepository.fetchUser();
      if (user == null) {
        throw Exception('not signed in');
      }
      await authRepository.updateEmail(
        oldEmail: user.email,
        newEmail: state.newEmail,
        password: state.password,
      );

      final UserEntity? newUser = await authRepository.fetchUser();

      if (newUser == null) {
        throw Exception('not signed in');
      }

      await userRepository.updateUser(newUser);

      userNotifier.updateUser(
        user.copyWith(
          email: state.newEmail,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
