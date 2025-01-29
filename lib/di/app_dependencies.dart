import 'package:flutter/material.dart';

import '../domain/repositories/todo_repository_interface.dart';

/// Класс для предоставления зависимостей
class AppDependencies extends InheritedWidget {
  final ITodoRepository todoRepository;

  const AppDependencies({
    super.key,
    required super.child,
    required this.todoRepository,
  });

  /// Метод для доступа к зависимостям из BuildContext
  static AppDependencies of(BuildContext context) {
    final AppDependencies? result = context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(result != null, 'No AppDependencies found in context');
    
    return result!;
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    // В данном случае зависимости не меняются после инициализации
    return false;
  }
}
