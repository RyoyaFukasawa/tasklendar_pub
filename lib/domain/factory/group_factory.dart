// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';

abstract class GroupFactory {
  GroupEntity createGroup({
    required String id,
    required String name,
    required Color color,
    required String emoji,
  });

  Future<GroupEntity?> createGroupFromId({
    required String id,
  });
}
