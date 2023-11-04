// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/factory/user_factory.dart';

class UserFactoryImpl implements UserFactory {
  @override
  Future<UserEntity> createUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  }) async {
    return UserEntity(
      id: id,
      email: email,
      status: status,
      authProvider: authProvider,
    );
  }
}
