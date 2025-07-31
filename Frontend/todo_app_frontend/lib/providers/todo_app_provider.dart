import 'package:flutter/material.dart';
import 'package:todo_app_frontend/models/todo_list_model.dart';
import 'package:todo_app_frontend/models/todo_model.dart';
import 'package:todo_app_frontend/services/api_service.dart';


class TodoAppProvider extends ChangeNotifier{
  List<dynamic> _todoLists = [];
  List<dynamic> _todos = [];

  List<dynamic> get todoLists => _todoLists;
  List<dynamic> get todos => _todos;


  bool _isLoading = false;
  String? _error;

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
      print('Error loading todo lists: $e');
    }

    finally {
      _setLoading(false);
    }
  }



  //? Create TodoList
  Future<void> createTodoList() async {
    _setLoading(true);
    _error = null;

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



  //? Read Todos
  Future<void> loadAllTodos(TodoList todoList) async {
    _setLoading(true);
    _error = null;

    try {
      final response = await ApiService.getTodos(todoListID: todoList.id);
      List<dynamic> data = response['data'];

      if (data.isEmpty) {
        _todos = [];
      }
      else {
        _todos = data.map((json) => Todo.fromJson(json)).toList();
      }
    }

    catch (e) {
      _error = e.toString();
      print('Error reading todo: $e');
    }
  }


  //? Create Todo
  Future<void> createTodo(String todoListID) async {
    _setLoading(true);
    _error = null;

    try {
      final response = await ApiService.createTodo(
        title: "New todo", 
        description: "", 
        todoListID: todoListID
      );

      final data = response['data'];

      final newTodo = Todo.fromJson(data);
      newTodo.setInitial(true);

      _todos.add(newTodo);

      print('Todo created successfully');
    }
    catch(e) {
      _error = e.toString();
      print("Error creating todo: $e");
    }
    finally {
      _setLoading(false);
    }
  }


  //? Update Todo
  Future<void> updateTodo(Todo todo, String title) async {
    _setLoading(true);
    _error = null;

    try {

    }
    catch(e) {

    }
    finally {
      _setLoading(false);
    }
  }


  //? Delete Todo
  Future<void> deleteTodo(Todo todo) async {
    _setLoading(true);
    _error = null;

    try {

    }
    catch(e) {

    }
    finally {
      _setLoading(false);
    }
  }



  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}