// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasklendar/data/datasources/group/group_datasource.dart';
import 'package:tasklendar/data/datasources/group/group_datasource_impl.dart';

// Project imports:
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';

part 'group_datasource.g.dart';

@riverpod
GroupDataSource groupDataSource(
  GroupDataSourceRef ref,
) {
  return GroupDataSourceImpl(
    loggedInUserId: ref.read(userNotifierProvider).id,
  );
}
