import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/main.dart';


class TodoList extends StatelessWidget {
  final String pageTitle;

  const TodoList({
      super.key,
      required this.pageTitle,
    });


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;    

    return Scaffold(
      appBar: header(colors, pageTitle),

      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Container(
          color: colors.backgroundColor,


        )
      ),
    );
  }
}
