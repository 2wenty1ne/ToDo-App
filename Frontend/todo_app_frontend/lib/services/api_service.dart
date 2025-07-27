import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiService {
  // static const String baseUrl = "http://localhost:4000/api/v1";
  static const String baseUrl = "http://10.0.2.2:4000/api/v1";
  static const String todoListUrl = '$baseUrl/todoLists';

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
    String? description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(todoListUrl),
        headers: headers,
        body: json.encode({
          'title': title,
          'description': description ?? '',
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
        throw Exception('Failed to update todo list: ${response.statusCode}');
      }

    }
    catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
