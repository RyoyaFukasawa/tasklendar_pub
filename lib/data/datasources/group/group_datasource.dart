// Project imports:
import 'package:tasklendar/data/models/group_model.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';

abstract class GroupDataSource {
  Future<List<GroupModel>> fetchAllGroups();
  Future<GroupModel?> fetchGroupById(String id);
  Future<void> addGroup(GroupEntity group);
  Future<void> updateGroup(GroupEntity group);
  Future<void> deleteGroup(GroupEntity group);
}
