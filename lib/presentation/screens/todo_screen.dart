import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_entity.dart';
import '../bloc/todo_cubit.dart';
import '../widgets/todo_item.dart';
import '../../di/app_dependencies.dart';

/// Экран отображения списка задач.
class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем зависимости из AppDependencies
    final dependencies = AppDependencies.of(context);

    return BlocProvider(
      create: (context) => TodoCubit(todoRepository: dependencies.todoRepository)..loadTodos(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ToDo Список'),
          ),
          body: BlocBuilder<TodoCubit, TodoState>(
            buildWhen: (_, current) => switch (current) {
              TodoError _ => false,
              _ => true,
            },
            builder: (context, state) => switch (state) {
              TodoLoading _ => _buildLoading(),
              TodoLoaded state => _buildLoaded(context, state.todos),
              _ => const SizedBox.shrink(),
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddTodoDialog(context),
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildLoaded(context, List<TodoEntity> todos) {
    if (todos.isEmpty) {
      return const Center(child: Text('Нет задач'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => context.read<TodoCubit>().toggleTodoStatus(todo),
          onDelete: () => context.read<TodoCubit>().deleteExistingTodo(todo.id),
        );
      },
    );
  }

  /// Отображение диалога добавления новой задачи.
  void _showAddTodoDialog(
    BuildContext context,
  ) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Добавить задачу'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Название задачи'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final title = controller.text;
              if (title.isEmpty) return;
              // Получаем Cubit из BlocProvider
              context.read<TodoCubit>().addNewTodo(title);
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
