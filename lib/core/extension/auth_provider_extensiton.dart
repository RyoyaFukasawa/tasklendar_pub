// Package imports:
import 'package:tasklendar/core/enums/auth_provider.dart';

extension AuthProviderExtension on AuthProvider {
  String toAuthProviderString() {
    switch (this) {
      case AuthProvider.google:
        return 'google';
      case AuthProvider.apple:
        return 'apple';
      case AuthProvider.email:
        return 'email';
      default:
        return 'anonymous';
    }
  }
}
