// Package imports:

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<User?> fetchAuthUser();
  Future<UserCredential> signInAnonymously();
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail({required String email});
  Future<UserCredential?> signInWithCredential(
      {required OAuthCredential credential});
  Future<bool> isEmailAlreadyRegistered({required String email});
}
