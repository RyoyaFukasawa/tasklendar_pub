// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/repository/user_repository_impl.dart';
import 'package:tasklendar/domain/repository/user_repository.dart';
import 'package:tasklendar/presentation/provider/datasources/user_datasource.dart/user_datasource.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(
  UserRepositoryRef ref,
) {
  return UserRepositoryImpl(userDataSource: ref.read(userDataSourceProvider));
}
