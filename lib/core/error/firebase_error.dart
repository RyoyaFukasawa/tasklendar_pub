class FirebaseError {
  static String authError(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'User not found. Please check your email or password.';
      case 'email-already-in-use':
        return 'Email already in use. Please use another email.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
