class TodoModel {
  String id;
  String title;
  bool isDone;
  bool isPinned;
  DateTime date;
  int priority;

  TodoModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.isPinned,
    required this.date,
    required this.priority,
  });
}
