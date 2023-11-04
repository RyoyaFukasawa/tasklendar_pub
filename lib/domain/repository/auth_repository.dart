// Project imports:
import 'package:tasklendar/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> fetchUser();
  Future<UserEntity> signInAnonymously();
  Future<UserEntity> mergeAnonymousAccount({
    required String email,
    required String password,
  });
  Future<UserEntity> mergeAnonymousAccountWithGoogle();
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> sendEmailVerification();
  Future<UserEntity?> googleSignIn();
  Future<bool> updateEmail({
    required String oldEmail,
    required String newEmail,
    required String password,
  });
}
