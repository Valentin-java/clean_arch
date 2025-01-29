import '../data/data_sources/todo_data_source_local.dart';
import '../data/mapper/todo_mapper.dart';
import '../data/repositories/todo_repository_impl.dart';
import '../domain/repositories/todo_repository_interface.dart';

/// Класс для регистрации и предоставления зависимостей.
class DependencyInjector {
  late final ITodoRepository todoRepository;
  late final TodoMapper todoMapper;

  /// Метод для инициализации всех зависимостей.
  Future<void> init() async {

    // Инициализация маппера
    todoMapper = TodoMapper();

    // Инициализация источника данных с передачей маппера
    final todoDataSourceLocal = TodoDataSourceLocal(todoMapper);

    // Репозиторий
    todoRepository = TodoRepositoryImpl(todoDataSourceLocal, todoMapper);
  }
}
