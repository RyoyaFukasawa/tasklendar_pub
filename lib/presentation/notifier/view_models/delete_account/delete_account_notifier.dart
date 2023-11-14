// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/error/firebase_error.dart';
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/data/datasources/auth/auth_datasource.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/provider/datasources/auth_datasource.dart/auth_datasource.dart';
import 'package:tasklendar/presentation/provider/repository/auth_repository/auth_repository.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';
import 'package:tasklendar/presentation/state/delete_account_page/delete_account_page_state.dart';
import 'package:tasklendar/presentation/state/user/user_state.dart';

part 'delete_account_notifier.g.dart';

@riverpod
class DeleteAccountNotifier extends _$DeleteAccountNotifier {
  @override
  DeleteAccountPageState build() {
    return const DeleteAccountPageState(
      isLoading: false,
      isAuth: false,
    );
  }

  void updateState(DeleteAccountPageState newState) {
    state = newState;
  }

  Future<void> reEmailAndPasswordAuth({
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isAuth: false);
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    try {
      final UserState userState = ref.watch(userNotifierProvider);

      final UserEntity user = await authRepository.signInWithEmailAndPassword(
        email: userState.email,
        password: password,
      );

      updateState(
        state.copyWith(
          isAuth: true,
        ),
      );

      Log.debug('$user');
    } on FirebaseAuthException catch (e) {
      Log.error(e.toString());
      final String error = FirebaseError.authError(e.code);
      updateState(
        state.copyWith(
          error: error,
        ),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> reGoogleAuth() async {
    state = state.copyWith(isLoading: true, error: null, isAuth: false);
    final AuthDataSource authDataSource = ref.read(authDataSourceProvider);
    final UserState userState = ref.watch(userNotifierProvider);
    try {
      final AuthCredential? credential =
          await authDataSource.fetchGoogleAuthCredential();

      final GoogleSignInAccount? user = await GoogleSignIn().signInSilently();
      final String? email = user?.email;

      if (credential != null && email == userState.email) {
        updateState(
          state.copyWith(
            credential: credential,
            isAuth: true,
          ),
        );
      } else if (email != userState.email) {
        updateState(
          state.copyWith(
            error: 'Different account from current login.',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Log.error(e.toString());
      final String error = FirebaseError.authError(e.code);
      updateState(
        state.copyWith(
          error: error,
        ),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteAccount() async {
    final AuthRepository authRepository = ref.read(authRepositoryProvider);
    final UserNotifier userNotifier = ref.read(userNotifierProvider.notifier);
    try {
      await authRepository.deleteAccount(
        credential: state.credential,
      );
      userNotifier.setDefaultUser();
    } catch (e) {
      rethrow;
    }
  }
}
