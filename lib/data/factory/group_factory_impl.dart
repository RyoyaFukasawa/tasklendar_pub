// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/factory/group_factory.dart';

class GroupFactoryImpl implements GroupFactory {
  GroupFactoryImpl();

  @override
  GroupEntity createGroup({
    required String id,
    required String name,
    required Color color,
    required String emoji,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) {
    return GroupEntity(
      id: id,
      name: name,
      color: color,
      emoji: emoji,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  Future<GroupEntity?> createGroupFromId({
    required String id,
  }) async {
    // try {
    //   // GroupDataSourceからグループデータを取得
    //   final GroupModel? groupModel = await _groupDataSource.fetchGroupById(id);

    //   if (groupModel == null) {
    //     return null;
    //   }

    //   // GroupModelをGroupEntityに変換して返す
    //   return GroupEntity(
    //     id: groupModel.id,
    //     name: groupModel.name,
    //     color: Color(groupModel.color),
    //     emoji: groupModel.emoji,
    //   );
    // } catch (e) {
    //   // エラーが発生した場合はnullを返す
    //   return null;
    // }
  }
}
