// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';

abstract class GroupRepository {
  Future<List<GroupEntity>> fetchAllGroups();
  Future<void> insertGroup(GroupEntity group);
  Future<void> updateGroup(
    String id, {
    String? name,
    String? emoji,
    Color? color,
  });
  Future<void> deleteGroup(String id);
}
