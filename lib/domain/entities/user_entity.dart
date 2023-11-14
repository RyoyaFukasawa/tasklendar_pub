// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';

class UserEntity {
  final String id;
  final String email;
  final String status;
  final AuthProvider authProvider;

  UserEntity({
    required this.id,
    required this.email,
    required this.status,
    required this.authProvider,
  });

  @override
  String toString() {
    return 'UserEntity{id: $id, email: $email, status: $status, authProvider: $authProvider}';
  }

  copyWith({
    String? id,
    String? email,
    String? status,
    AuthProvider? authProvider,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      status: status ?? this.status,
      authProvider: authProvider ?? this.authProvider,
    );
  }
}
