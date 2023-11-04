// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/datasources/auth/auth_datasource.dart';
import 'package:tasklendar/data/datasources/auth/auth_datasource_impl.dart';

part 'auth_datasource.g.dart';

@riverpod
AuthDataSource authDataSource(
  AuthDataSourceRef ref,
) {
  return AuthDataSourceImpl();
}
