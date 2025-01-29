part of './todo_cubit.dart';

/// Абстрактное состояние Cubit.
sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

/// Состояние начальной загрузки.
class TodoInitial extends TodoState {}

/// Состояние загрузки данных.
class TodoLoading extends TodoState {}

/// Состояние с успешно загруженными задачами.
class TodoLoaded extends TodoState {
  final List<TodoEntity> todos;

  const TodoLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

/// Состояние с ошибкой.
class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object> get props => [message];
}
