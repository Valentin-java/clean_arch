import '../models/todo_model.dart';
import '../../domain/entities/todo_entity.dart';

class TodoMapper {

  /// Entity -> Model
  TodoModel fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      isCompleted: entity.isCompleted,
    );
  }

  /// Model -> Entity
  TodoEntity toEntity(TodoModel model) {
    return TodoEntity(
      id: model.id,
      title: model.title,
      isCompleted: model.isCompleted,
    );
  }

  /// JSON -> Model
  TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  /// Model -> JSON
  Map<String, dynamic> toJson(TodoModel model) {
    return {
      'id': model.id,
      'title': model.title,
      'isCompleted': model.isCompleted,
    };
  }
}