// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';

abstract class GroupRepository {
  Future<List<GroupEntity>> fetchAllGroups();
  Future<void> insertGroup(GroupEntity group);
  Future<void> updateGroup(GroupEntity group);
  Future<void> deleteGroup(GroupEntity group);
}
