// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasklendar/core/error/firebase_error.dart';

// Project imports:
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';
import 'package:tasklendar/presentation/state/auth/sign_in_state.dart';

part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    return const SignInState(
      isLoading: false,
      isRegistered: false,
      error: '',
    );
  }

  void updateState(SignInState newState) {
    state = newState;
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    try {
      final UserEntity user = await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Log.debug(user.toString());

      userNotifier.updateUser(
        user,
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

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    try {
      final UserEntity? user = await authRepository.googleSignIn();

      if (user == null) {
        FirebaseAuthException(
          code: 'user-not-found',
        );
        return false;
      }

      Log.debug(user.toString());

      userNotifier.updateUser(
        user,
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
