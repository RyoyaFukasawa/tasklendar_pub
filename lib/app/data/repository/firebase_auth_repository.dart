import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<User?> getUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      print('getUser failed: $e');
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('signInWithEmailAndPassword failed: $e');
      rethrow;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('signUpWithEmailAndPassword failed: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('signOut failed: $e');
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } catch (e) {
      print('sendEmailVerification failed: $e');
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('sendPasswordResetEmail failed: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signInWithCredential(
      {required OAuthCredential credential}) async {
    try {
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print('signInWithCredential failed: $e');
    }
    return null;
  }

  Future<bool> isEmailAlreadyRegistered({required String email}) async {
    try {
      final result = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      print('isEmailAlreadyInUse failed: $e');
      rethrow;
    }
  }
}
