import '../models/todo_model.dart';

/// Интерфейс для источника данных задач.
abstract class ITodoDataSource {
  /// Получение списка задач.
  Future<List<TodoModel>> getTodos();

  /// Сохранение списка задач.
  Future<void> saveTodos(List<TodoModel> todos);
}