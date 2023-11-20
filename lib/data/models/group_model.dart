// Project imports:
import 'package:tasklendar/domain/entities/group/group_entity.dart';

class GroupModel {
  GroupModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String emoji;
  int color;
  DateTime createdAt;
  DateTime updatedAt;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json['id'],
        name: json['name'],
        emoji: json['emoji'],
        color: json['color'],
        createdAt: DateTime.parse(json['createdAt'].toDate().toString()),
        updatedAt: DateTime.parse(json['updatedAt'].toDate().toString()),
      );

  factory GroupModel.fromEntity(GroupEntity entity) => GroupModel(
        id: entity.id,
        name: entity.name,
        emoji: entity.emoji,
        color: entity.color.value,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'emoji': emoji,
        'color': color,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
