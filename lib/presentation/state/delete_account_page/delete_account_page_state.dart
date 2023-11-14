// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:

part 'delete_account_page_state.freezed.dart';

@freezed
abstract class DeleteAccountPageState with _$DeleteAccountPageState {
  const factory DeleteAccountPageState({
    AuthCredential? credential,
    required bool isLoading,
    String? error,
    required bool isAuth,
  }) = _DeleteAccountPageState;
}
