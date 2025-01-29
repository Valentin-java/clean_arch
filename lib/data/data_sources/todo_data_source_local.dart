import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../mapper/todo_mapper.dart';
import '../models/todo_model.dart';
import './todo_data_source_interface.dart';

/// Локальный источник данных для хранения задач.
class TodoDataSourceLocal implements ITodoDataSource {
  static const String todoListKey = 'TODO_LIST';
  final TodoMapper todoMapper;

  const TodoDataSourceLocal(this.todoMapper);

  /// Получение списка задач из локального хранилища.
  @override
  Future<List<TodoModel>> getTodos() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(todoListKey);
    if (jsonString == null || jsonString.isEmpty) return [];

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    return jsonList.map((item) => todoMapper.fromJson(item as Map<String, dynamic>)).toList();
  }

  /// Сохранение списка задач в локальное хранилище.
  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonList = todos.map((todo) => todoMapper.toJson(todo)).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(todoListKey, jsonString);
  }
}
