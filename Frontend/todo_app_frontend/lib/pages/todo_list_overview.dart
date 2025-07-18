import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/components/list_item.dart';
import 'package:todo_app_frontend/main.dart';

class TodoListOverview extends StatelessWidget {
  const TodoListOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.backgroundColor,
      child: Column(
        children: [
          Header(title: "Todo Listenn", showBackButton: false,),

          ListItem(title: "Dailies", amountText: "2 Tasks"),
          ListItem(title: "Todo App", amountText: "5 Tasks")
        ],
      ),
    );
  }
}
