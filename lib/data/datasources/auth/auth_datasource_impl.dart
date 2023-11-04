// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:tasklendar/data/datasources/auth/auth_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> fetchAuthUser() async {
    try {
      // reload the user to get the latest updates
      firebaseAuth.currentUser?.reload();

      return firebaseAuth.currentUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInAnonymously() async {
    try {
      return await firebaseAuth.signInAnonymously();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw Exception('User not found');
      }

      await firebaseAuth.currentUser!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential?> signInWithCredential(
      {required OAuthCredential credential}) async {
    try {
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print('signInWithCredential failed: $e');
    }
    return null;
  }

  @override
  Future<bool> isEmailAlreadyRegistered({required String email}) async {
    try {
      final result = await firebaseAuth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
