// Package imports:
import 'package:email_validator/email_validator.dart';
import 'package:emoji_regex/emoji_regex.dart';
import 'package:tasklendar/core/enums/auth_provider.dart';

extension StringExtension on String {
  bool isValidEmail() {
    return EmailValidator.validate(this);
  }

  bool isValidPassword() {
    const String pattern = r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9]{8,}$';
    return RegExp(pattern).hasMatch(this);
  }

  bool isValidEmoji() {
    return emojiRegex().hasMatch(this);
  }

  bool isValidGroupName() {
    const String pattern = r'.{1,10}';
    return RegExp(pattern).hasMatch(this);
  }

  bool isValidHexColor() {
    const String pattern = r'^#?([0-9a-fA-F]{6})$';
    return RegExp(pattern).hasMatch(this);
  }

  AuthProvider toAuthProvider() {
    switch (this) {
      case 'google':
        return AuthProvider.google;
      case 'apple':
        return AuthProvider.apple;
      case 'email':
        return AuthProvider.email;
      default:
        return AuthProvider.anonymous;
    }
  }
}
