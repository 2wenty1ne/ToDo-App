import 'package:todo_app_frontend/models/list_item_interface.dart';

class Todo implements ListableItem {
  @override
  String title;
  final String id;
  String description;
  bool completed;
  final String todoListID;
  Map<String, dynamic> todoGroupID;
  final DateTime createdAt;
  DateTime updatedAt;

  bool isInitial = false;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.todoListID,
    required this.todoGroupID,
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

  void updateFrom(Todo other) {
    title = other.title;
    description = other.description;
    completed = other.completed;
    todoGroupID = other.todoGroupID;
    updatedAt = other.updatedAt;
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title : json['title'],
      description : json['description'],
      completed : json['completed'],
      todoListID : json['todo_list_id'],
      todoGroupID : json['todo_group_id'],
      createdAt : DateTime.parse(json['created_at']),
      updatedAt : DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "completed": completed,
      "todo_list_id": todoListID,
      "todo_group_id": todoGroupID,
      "created_at": createdAt,
      "updated_at": updatedAt
    };
  }

}
