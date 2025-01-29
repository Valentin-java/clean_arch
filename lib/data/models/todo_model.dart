import '../../domain/entities/todo_entity.dart';

/// Модель задачи расширяющая сущность [TodoEntity]

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.isCompleted,
  });
}
