import 'package:flutter/material.dart';

import './di/app_dependencies.dart';
import './di/setup.dart';
import './presentation/screens/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация зависимостей
  final injector = DependencyInjector();
  await injector.init();

  runApp(AppDependencies(
    todoRepository: injector.todoRepository,
    child: const MyApp(),
  ));
}

/// Главный виджет приложения.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ToDo App',
      home: TodoScreen(),
    );
  }
}
