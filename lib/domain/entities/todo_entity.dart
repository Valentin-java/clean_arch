/// Сущность задачи
class TodoEntity {
  final String id;
  final String title;
  final bool isCompleted;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
}
