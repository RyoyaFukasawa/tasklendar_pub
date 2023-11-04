// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/datasources/user/user_datasource.dart';
import 'package:tasklendar/data/datasources/user/user_datasource_impl.dart';

part 'user_datasource.g.dart';

@riverpod
UserDataSource userDataSource(
  UserDataSourceRef ref,
) {
  return UserDataSourceImpl();
}
