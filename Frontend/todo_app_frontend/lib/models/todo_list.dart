
class TodoList {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoList({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

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
