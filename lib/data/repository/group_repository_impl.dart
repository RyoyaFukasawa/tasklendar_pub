// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:tasklendar/data/datasources/group/group_datasource.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/repository/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  GroupRepositoryImpl({
    required GroupDataSource groupDataSource,
  }) : _groupDataSource = groupDataSource;

  final GroupDataSource _groupDataSource;

  @override
  Future<void> insertGroup(GroupEntity group) async {
    try {
      await _groupDataSource.addGroup(group);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroup(String id) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

  @override
  Future<List<GroupEntity>> fetchAllGroups() {
    // TODO: implement fetchAllGroups
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroup(String id,
      {String? name, String? emoji, Color? color}) {
    // TODO: implement updateGroup
    throw UnimplementedError();
  }
}
