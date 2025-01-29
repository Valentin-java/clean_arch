import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository_interface.dart';

part 'todo_state.dart';

/// Cubit для управления состоянием задач.
class TodoCubit extends Cubit<TodoState> {
  final ITodoRepository todoRepository;

  TodoCubit({
    required this.todoRepository,
  }) : super(TodoInitial());

  /// Загрузка задач.
  Future<void> loadTodos() async {
    emit(TodoLoading());
    try {
      final todos = await todoRepository.getTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(const TodoError('Не удалось загрузить задачи'));
    }
  }

  /// Добавление новой задачи.
  Future<void> addNewTodo(String title) async {
    try {
      final todo = TodoEntity(
        id: DateTime.now().toIso8601String(),
        title: title,
        isCompleted: false,
      );
      await todoRepository.addTodo(todo);
      await loadTodos();
    } catch (e) {
      emit(const TodoError('Не удалось добавить задачу'));
    }
  }

  /// Переключение статуса задачи.
  Future<void> toggleTodoStatus(TodoEntity todo) async {
    try {
      final updatedTodo = TodoEntity(
        id: todo.id,
        title: todo.title,
        isCompleted: !todo.isCompleted,
      );
      await todoRepository.updateTodo(updatedTodo);
      await loadTodos();
    } catch (e) {
      emit(const TodoError('Не удалось обновить задачу'));
    }
  }

  /// Удаление задачи.
  Future<void> deleteExistingTodo(String id) async {
    try {
      await todoRepository.deleteTodo(id);
      await loadTodos();
    } catch (e) {
      emit(const TodoError('Не удалось удалить задачу'));
    }
  }
}
