
import 'package:todo_app_frontend/models/list_item_interface.dart';

class TodoList implements ListableItem{
  @override
  String title;
  final String id;
  final DateTime createdAt;
  DateTime updatedAt;

  bool isInitial = false;

  TodoList({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool getInitialStatus() {
    return isInitial;
  }

  void setInitial(bool status) {
    isInitial = status;
  }

  void updateFrom(TodoList other) {
    title = other.title;
    updatedAt = other.updatedAt;
  }

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      id: json['id'], 
      title: json['title'], 
      createdAt: DateTime.parse(json['created_at']), 
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "created_at": createdAt,
      "updated_at": updatedAt
    };
  }

}
