// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    required bool isLoading,
    required bool isRegistered,
    String? error,
  }) = _SignInState;
}
