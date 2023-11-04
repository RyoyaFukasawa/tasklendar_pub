// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/data/models/user_model.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> createUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  });
  Future<UserModel?> fetchUser(id);
  Future<void> updateUser(UserEntity user);
}
