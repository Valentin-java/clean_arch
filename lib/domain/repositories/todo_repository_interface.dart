import '../entities/todo_entity.dart';

/// Абстрактный репозиторий для работы с задачами.
abstract class ITodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(String id);
}
