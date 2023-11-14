// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/core/enums/user_status.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/presentation/state/user/user_state.dart';

part 'user_notifier.g.dart';

@Riverpod(
  keepAlive: true,
)
class UserNotifier extends _$UserNotifier {
  @override
  UserState build() {
    return const UserState(
      id: '',
      email: '',
      status: UserStatus.guest,
      authProvider: AuthProvider.anonymous,
    );
  }

  void setDefaultUser() {
    state = const UserState(
      id: '',
      email: '',
      status: UserStatus.guest,
      authProvider: AuthProvider.anonymous,
    );
  }

  Future<void> updateUser(UserEntity value) async {
    state = UserState(
      id: value.id,
      email: value.email,
      status: statusToEnum(value.status),
      authProvider: value.authProvider,
    );
  }

  void updateId(String value) {
    state = state.copyWith(id: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updateStatus(UserStatus value) {
    state = state.copyWith(status: value);
  }

  UserStatus statusToEnum(String value) {
    switch (value) {
      case 'member':
        return UserStatus.member;
      case 'subscribed':
        return UserStatus.subscribed;
      default:
        return UserStatus.guest;
    }
  }
}
