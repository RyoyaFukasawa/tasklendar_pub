// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:tasklendar/data/datasources/group/group_datasource.dart';
import 'package:tasklendar/data/models/group_model.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';

class GroupDataSourceImpl implements GroupDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GroupDataSourceImpl({
    required String loggedInUserId,
  }) : _loggedInUserId = loggedInUserId;

  final String _loggedInUserId;

  // Getter //
  CollectionReference<Map<String, dynamic>> get _groupCollection =>
      _firestore.collection('users').doc(_loggedInUserId).collection('groups');

  @override
  Future<List<GroupModel>> fetchAllGroups() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> res =
          await _groupCollection.get();

      return res.docs.map(
        (QueryDocumentSnapshot<Map<String, dynamic>> e) {
          return GroupModel.fromJson(e.data());
        },
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupModel?> fetchGroupById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> res =
          await _groupCollection.doc(id).get();

      if (res.data() == null) {
        return null;
      }

      return GroupModel.fromJson(res.data()!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addGroup(GroupEntity group) {
    try {
      final GroupModel groupModel = GroupModel.fromEntity(group);
      return _groupCollection.doc(group.id).set(groupModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGroup(GroupEntity group) {
    try {
      final GroupModel groupModel = GroupModel.fromEntity(group);
      return _groupCollection.doc(group.id).update(groupModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroup(GroupEntity group) async {
    try {
      return _groupCollection.doc(group.id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
