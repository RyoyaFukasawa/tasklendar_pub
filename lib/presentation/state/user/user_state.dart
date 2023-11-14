// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/core/enums/user_status.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    required String id,
    required String email,
    required UserStatus status,
    required AuthProvider authProvider,
  }) = _UserState;
}
