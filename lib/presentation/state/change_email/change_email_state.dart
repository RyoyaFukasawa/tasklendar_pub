// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_email_state.freezed.dart';

@freezed
abstract class ChangeEmailState with _$ChangeEmailState {
  const factory ChangeEmailState({
    required GlobalKey<FormState> formKey,
    required String newEmail,
    required String password,
  }) = _ChangeEmailState;
}
