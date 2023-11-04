// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/repository/auth_repository_impl.dart';
import 'package:tasklendar/domain/repository/auth_repository.dart';
import 'package:tasklendar/presentation/provider/datasources/auth_datasource.dart/auth_datasource.dart';
import 'package:tasklendar/presentation/provider/datasources/user_datasource.dart/user_datasource.dart';
import 'package:tasklendar/presentation/provider/factory/user_factory/user_factory.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(
  AuthRepositoryRef ref,
) {
  return AuthRepositoryImpl(
    authDataSource: ref.read(authDataSourceProvider),
    userDataSource: ref.read(userDataSourceProvider),
    userFactory: ref.read(userFactoryProvider),
  );
}
