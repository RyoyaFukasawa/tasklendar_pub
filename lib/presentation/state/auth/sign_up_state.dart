// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    required bool isLoading,
    required bool isRegistered,
    String? error,
  }) = _SignUpState;
}
