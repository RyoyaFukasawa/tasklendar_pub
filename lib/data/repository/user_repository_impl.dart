// Project imports:
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/data/datasources/user/user_datasource.dart';
import 'package:tasklendar/data/models/user_model.dart';
import 'package:tasklendar/domain/entities/user_entity.dart';
import 'package:tasklendar/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

  final UserDataSource _userDataSource;

  @override
  Future<void> createUser({
    required String id,
    required String email,
    required String status,
    required AuthProvider authProvider,
  }) async {
    try {
      await _userDataSource.createUser(
        id: id,
        email: email,
        status: status,
        authProvider: authProvider,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> fetchUser(id) async {
    try {
      final UserModel? userModel = await _userDataSource.fetchUserById(id);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      await _userDataSource.updateUser(
        id: user.id,
        email: user.email,
        status: user.status,
        authProvider: user.authProvider,
      );
    } catch (e) {
      rethrow;
    }
  }
}
