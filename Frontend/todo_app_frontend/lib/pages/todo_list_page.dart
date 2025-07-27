import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/main.dart';
import 'package:todo_app_frontend/models/todo_list.dart';


class TodoListPage extends StatelessWidget {
  final TodoList todoList;

  const TodoListPage({
      super.key,
      required this.todoList,
    });


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;    

    return Scaffold(
      appBar: header(colors, todoList.title, context, true),

      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Container(
          color: colors.backgroundColor,


        )
      ),
    );
  }
}
