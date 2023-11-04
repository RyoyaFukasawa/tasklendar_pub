// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';

abstract class UserFactory {
  Future<UserEntity> createUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  });
}
