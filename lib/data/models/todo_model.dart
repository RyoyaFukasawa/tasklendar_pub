class TodoModel {
  TodoModel({
    required this.id,
    required this.name,
    required this.date,
    required this.duration,
    required this.color,
    required this.isDone,
    this.groupId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  DateTime date;
  int duration;
  int color;
  bool isDone;
  String? groupId;
  DateTime createdAt;
  DateTime updatedAt;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"].toDate().toString()),
        duration: json["duration"],
        color: json["color"],
        isDone: json["isDone"],
        groupId: json["groupId"],
        createdAt: DateTime.parse(json["createdAt"].toDate().toString()),
        updatedAt: DateTime.parse(json["updatedAt"].toDate().toString()),
      );

  @override
  String toString() {
    return 'TodoModel(id: $id, name: $name, date: $date, duration: $duration, isDone: $isDone, groupId: $groupId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
