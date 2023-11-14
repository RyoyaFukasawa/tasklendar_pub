import 'package:tasklendar/domain/entities/todo/todo_entity.dart';

class TodoModel {
  TodoModel({
    required this.id,
    required this.name,
    this.date,
    required this.duration,
    required this.times,
    required this.currentTimes,
    required this.color,
    required this.isDone,
    required this.monthCellIndex,
    this.groupId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  DateTime? date;
  int duration;
  int times;
  int currentTimes;
  int color;
  bool isDone;
  int monthCellIndex;
  String? groupId;
  DateTime createdAt;
  DateTime updatedAt;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"].toDate().toString()),
        duration: json["duration"],
        times: json["times"],
        currentTimes: json["currentTimes"],
        color: json["color"],
        isDone: json["isDone"],
        monthCellIndex: json["monthCellIndex"],
        groupId: json["groupId"],
        createdAt: DateTime.parse(json["createdAt"].toDate().toString()),
        updatedAt: DateTime.parse(json["updatedAt"].toDate().toString()),
      );

  factory TodoModel.fromEntity(TodoEntity entity) => TodoModel(
        id: entity.id,
        name: entity.name,
        date: entity.date,
        duration: entity.duration,
        times: entity.times,
        currentTimes: entity.currentTimes,
        color: entity.color.value,
        isDone: entity.isDone,
        monthCellIndex: entity.monthCellIndex,
        groupId: entity.groupId,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  @override
  String toString() {
    return 'TodoModel(id: $id, name: $name, date: $date, duration: $duration, times: $times, currentTimes: $currentTimes, color: $color, isDone: $isDone, monthCellIndex: $monthCellIndex, groupId: $groupId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "duration": duration,
        "times": times,
        "currentTimes": currentTimes,
        "color": color,
        "isDone": isDone,
        "monthCellIndex": monthCellIndex,
        "groupId": groupId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
