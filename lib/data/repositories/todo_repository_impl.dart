import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository_interface.dart';
import '../mapper/todo_mapper.dart';
import '../models/todo_model.dart';
import '../data_sources/todo_data_source_interface.dart';

/// Реализация интерфейса [ITodoRepository], использующая локальный источник данных.
class TodoRepositoryImpl implements ITodoRepository {
  final ITodoDataSource dataSource;
  final TodoMapper todoMapper;

  TodoRepositoryImpl(this.dataSource, this.todoMapper);

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todoModels = await dataSource.getTodos();
    final newTodoModel = todoMapper.fromEntity(todo);
    todoModels.add(newTodoModel);
    await dataSource.saveTodos(todoModels);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todoModels = await dataSource.getTodos();
    todoModels.removeWhere((todo) => todo.id == id);
    await dataSource.saveTodos(todoModels);
  }

  @override
  Future<List<TodoEntity>> getTodos() async {
    final todoModels = await dataSource.getTodos();

    return todoModels.map((todoModel) => todoMapper.toEntity(todoModel)).toList();
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final todoModels = await dataSource.getTodos();
    final index = todoModels.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todoModels[index] = TodoModel(
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted,
      );
      await dataSource.saveTodos(todoModels);
    }
  }
}
