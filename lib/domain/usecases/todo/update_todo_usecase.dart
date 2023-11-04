abstract class UpdateTodoUseCase {
  Future<void> execute(
    String id, {
    String? name,
    DateTime? date,
    int? duration,
    bool? isDone,
    String? groupId,
  });
}
