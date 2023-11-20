// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasklendar/data/repository/group_repository_impl.dart';

// Project imports:
import 'package:tasklendar/domain/repository/group_repository.dart';
import 'package:tasklendar/presentation/provider/datasources/group_datasource.dart/group_datasource.dart';
import 'package:tasklendar/presentation/provider/factory/group_factory/group_factory.dart';
part 'group_repository.g.dart';

@riverpod
GroupRepository groupRepository(
  GroupRepositoryRef ref,
) {
  return GroupRepositoryImpl(
    groupDataSource: ref.read(groupDataSourceProvider),
    groupFactory: ref.read(groupFactoryProvider),
  );
}
