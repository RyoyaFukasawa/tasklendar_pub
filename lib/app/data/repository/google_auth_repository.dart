import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthRepository {
  GoogleAuthRepository({GoogleSignIn? googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn();

  final GoogleSignIn _googleSignIn;

  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      print('signIn failed: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print('signOut failed: $e');
    }
  }

  Future<GoogleSignInAccount?> getUser() async {
    try {
      return _googleSignIn.currentUser;
    } catch (e) {
      print('getUser failed: $e');
    }
    return null;
  }
}
