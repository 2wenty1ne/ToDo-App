import 'package:flutter/material.dart';
import 'package:todo_app_frontend/models/todo_list.dart';
import 'package:todo_app_frontend/services/api_service.dart';


class TodoAppProvider extends ChangeNotifier{
  List<TodoList> _todoLists = [];
  bool _isLoading = false;
  String? _error;

  List<TodoList> get todoLists => _todoLists;
  bool get isLoading => _isLoading;
  String? get error => _error;


  //? Read TodoLists
  Future<void> loadAllTodoLists() async {
    _setLoading(true);
    _error = null;

    try {
      final data = await ApiService.getTodoLists();
      _todoLists = data.map((json) => TodoList.fromJson(json)).toList();
    }

    catch (e) {
      _error = e.toString();
      print('Error loaing todo lists: $e');
    }

    _setLoading(false);
  }


  //? Create TodoList
  Future<void> createTodoList(String title) async {
    _setLoading(true);
    _error = null;

    try {
      final data = await ApiService.createTodoList(
        title: title
      );

      final newTodoList = TodoList.fromJson(data);
      _todoLists.add(newTodoList);

      print('Todo list created successfully');
    }
    catch (e) {
      _error = e.toString();
      print('Error creating todo list: $e');
    }

    _setLoading(false);
  }

  //TODO UPDATE / DELETE TODOLIST

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}