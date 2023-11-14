// Project imports:
import 'package:tasklendar/config/constraints/firebase_auth_error_code.dart';

class FirebaseError {
  static String authError(String errorCode) {
    switch (errorCode) {
      case FirebaseAuthErrorCode.userNotFound:
        return 'User not found. Please check your email or password.';
      case FirebaseAuthErrorCode.emailAlreadyInUse:
        return 'Email already in use. Please use another email.';
      case FirebaseAuthErrorCode.wrongPassword:
        return 'Wrong password. Please check your password.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
