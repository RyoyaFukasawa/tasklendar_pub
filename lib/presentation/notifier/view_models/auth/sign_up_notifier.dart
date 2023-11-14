// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/error/firebase_error.dart';
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/domain/repository/user_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';
import 'package:tasklendar/presentation/provider/repository/user_repository/user_repository.dart';
import 'package:tasklendar/presentation/state/auth/sign_up_state.dart';

part 'sign_up_notifier.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  SignUpState build() {
    return const SignUpState(
      isLoading: false,
      isRegistered: false,
    );
  }

  void updateState(SignUpState newState) {
    state = newState;
  }

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    try {
      final UserEntity user = await authRepository.mergeAnonymousAccount(
        email: email,
        password: password,
      );

      // メール認証のリクエストを送信
      await authRepository.sendEmailVerification();

      // providerのログインユーザー情報を更新
      ref.read(userNotifierProvider.notifier).updateUser(
            user.copyWith(
              status: 'member',
            ),
          );

      // ユーザー情報を更新
      await userRepository.updateUser(user);

      userNotifier.updateUser(
        user.copyWith(
          status: 'member',
        ),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      Log.error(e.toString());
      final String error = FirebaseError.authError(e.code);
      state = state.copyWith(
        error: error,
      );
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> signUpWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    try {
      final UserEntity user =
          await authRepository.mergeAnonymousAccountWithGoogle();

      // メール認証のリクエストを送信
      await authRepository.sendEmailVerification();

      // providerのログインユーザー情報を更新
      ref.read(userNotifierProvider.notifier).updateUser(
            user.copyWith(
              status: 'member',
            ),
          );

      // ユーザー情報を更新
      await userRepository.updateUser(user);

      userNotifier.updateUser(
        user.copyWith(
          status: 'member',
        ),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      Log.error(e.toString());
      final String error = FirebaseError.authError(e.code);
      state = state.copyWith(
        error: error,
      );
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
