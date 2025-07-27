import 'package:flutter/material.dart';
import 'package:todo_app_frontend/models/todo_list.dart';
import 'package:todo_app_frontend/services/api_service.dart';


class TodoAppProvider extends ChangeNotifier{
  List<dynamic> _todoLists = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get todoLists => _todoLists;
  bool get isLoading => _isLoading;
  String? get error => _error;


  //? Read TodoLists
  Future<void> loadAllTodoLists() async {
    _setLoading(true);
    _error = null;


    try {
      final response = await ApiService.getTodoLists();
      final data = response['data'];
      _todoLists = data.map((json) => TodoList.fromJson(json)).toList();
    }

    catch (e) {
      _error = e.toString();
      print('Error loaing todo lists gew: $e');
    }

    finally {
      _setLoading(false);
    }
  }


  void addEmptyTodoListItem() {

  }


  //? Create TodoList
  Future<void> createTodoList() async {
    _setLoading(true);
    _error = null;

    print("creating todo list");

    try {
      final response = await ApiService.createTodoList(
        title: "New list"
      );

      final data = response['data'];

      final newTodoList = TodoList.fromJson(data);
      newTodoList.setInitial(true);

      _todoLists.add(newTodoList);

      print('Todo list created successfully');
    }
    catch (e) {
      _error = e.toString();
      print('Error creating todo list: $e');
    }

    finally {
      _setLoading(false);
    }
  }


  //? Update TodoList
  Future<void> updateTodoList(TodoList todoList, String title) async {
    _setLoading(true);

    try {
      final response = await ApiService.updateTodoList(
        id: todoList.id, 
        title: title
      );

      final data = response['data'];

      final updatedTodoList = TodoList.fromJson(data);

      todoList.updateFrom(updatedTodoList);
      todoList.setInitial(false);
    }
    catch(e) {
      _error = e.toString();
      print('Error updating todo list: $e');
    }
    finally {
      _setLoading(false);
    }
  }


  //? Delete TodoList
  Future<void> deleteTodoList(TodoList todoList) async {
    _setLoading(true);

    _error = null;

    try {
      await ApiService.deleteTodoList(
        id: todoList.id
      );

      _todoLists.remove(todoList);

      print("Todo list deleted successfully");
    }

    catch (e) {
      _error = e.toString();
      print('Error deleting todo list: $e');
    }

    finally {
      _setLoading(false);
    }
  }

  //TODO UPDATE TODOLIST




  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}