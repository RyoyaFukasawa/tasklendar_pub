// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/data/models/user_model.dart';

abstract class UserDataSource {
  Future<void> createUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  });
  Future<UserModel?> fetchUserById(String id);
  Future<UserModel?> fetchUserByEmail(String email);
  Future<void> updateUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  });
  Future<void> deleteUser(String id);
}
