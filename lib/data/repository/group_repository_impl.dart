// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/data/datasources/group/group_datasource.dart';
import 'package:tasklendar/data/models/group_model.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/factory/group_factory.dart';
import 'package:tasklendar/domain/repository/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  GroupRepositoryImpl({
    required GroupDataSource groupDataSource,
    required GroupFactory groupFactory,
  })  : _groupDataSource = groupDataSource,
        _groupFactory = groupFactory;

  final GroupDataSource _groupDataSource;
  final GroupFactory _groupFactory;

  @override
  Future<void> insertGroup(GroupEntity group) async {
    try {
      await _groupDataSource.addGroup(group);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroup(GroupEntity group) async {
    try {
      await _groupDataSource.deleteGroup(group);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GroupEntity>> fetchAllGroups() async {
    try {
      final List<GroupModel> res = await _groupDataSource.fetchAllGroups();

      Log.debug(res.toString());

      final List<GroupEntity> groupList = [];

      for (var e in res) {
        final GroupEntity groupEntity = _groupFactory.createGroup(
          id: e.id,
          name: e.name,
          emoji: e.emoji,
          color: Color(e.color),
          updatedAt: e.updatedAt,
          createdAt: e.createdAt,
        );
        groupList.add(groupEntity);
      }

      return groupList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGroup(GroupEntity group) async {
    try {
      await _groupDataSource.updateGroup(group);
    } catch (e) {
      rethrow;
    }
  }
}
