import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = "http://10.0.2.2:4000/api/v1";     //? Virtual Phone
  //static const String baseUrl = "http://192.168.2.100:4000/api/v1";   //? Physical Phone
  
  static const String todoListUrl = '$baseUrl/todoLists';
  static const String todoUrl = '$baseUrl/todos';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };


  static Future<Map<String, dynamic>> getTodoLists() async {
    try {
      final response = await http.get(
        Uri.parse(todoListUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      else {
        throw Exception('Failed to load todo lists: ${response.statusCode}');
      }
    }

    catch (e) {
      throw Exception('Network error: $e');
    }
  }



  static Future<Map<String, dynamic>> createTodoList({
    required String title,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(todoListUrl),
        headers: headers,
        body: json.encode({
          'title': title,
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      else {
        throw Exception('Failed to create todo list: ${response.statusCode}');
      }
    }

    catch (e) {
      throw Exception('Network error: $e');
    }
  }



  static Future<Map<String, dynamic>> updateTodoList({
    required String id,
    required String title
  }) async {
    try {
      final response = await http.patch(
        Uri.parse(todoListUrl),
        headers: headers,
        body: json.encode({
          'id': id,
          'title': title,
        })
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      else {
        throw Exception('Failed to update todo list: ${response.statusCode}}');
      }

    }
    catch(e) {
      throw Exception('Network error: $e'); 
    }
  }



  static Future<void> deleteTodoList({
    required String id,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(todoListUrl),
        headers: headers,
        body: json.encode({
          'id': id,
        })
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete todo list: ${response.statusCode}');
      }
    }
    
    catch (e) {
      throw Exception('Network error: $e');
    }
  }



  //? TODOS
  static Future<Map<String, dynamic>> getTodos({
    required String todoListID,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/alltodos'),
        headers: headers,
        body: json.encode({
          "todo_list_id": todoListID,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      else {
        print(response.body);
        throw Exception('Failed to load todos: ${response.statusCode}');
      }
    }

    catch (e) {
      throw Exception('Network error: $e');
    }
  }



  static Future<Map<String, dynamic>> createTodo({
    required String title,
    required String todoListID,
    String? todoGroupID,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'title': title,
        'todo_list_id': todoListID,
      };

      if (todoGroupID != null) {
        requestBody['todo_group_id'] = todoGroupID;
      }

      final response = await http.post(
        Uri.parse(todoUrl),
        headers: headers,
        body: json.encode(requestBody)
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    }

    catch (e) {
      throw Exception('Network error: $e');
    }
  }



  static Future<Map<String, dynamic>> updateTodo({
    required String id,
    required String title,
    required String description,
    required bool completed,
    String? todoGroupID
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'id': id,
        'title': title,
        'description': description,
        'completed': completed,
      };

      if (todoGroupID != null) {
        requestBody['todo_group_id'] = todoGroupID;
      }

      final response = await http.patch(
        Uri.parse(todoUrl),
        headers: headers,
        body: json.encode(requestBody)
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      else {
        throw Exception('Failed to update todo list: ${response.statusCode}}');
      }
    }
    catch(e) {
      throw Exception('Network error: $e'); 
    }
  }



  static Future<void> deleteTodo({
    required String id, 
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(todoUrl),
        headers: headers,
        body: json.encode({
          'id': id
        })
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete todo: ${response.statusCode}');
      }
    }

    catch (e) {
      throw Exception('Network error: $e');
    }
  }



}
