import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/components/list_item.dart';
import 'package:todo_app_frontend/components/nav_circle.dart';
import 'package:todo_app_frontend/main.dart';

class TodoListOverview extends StatelessWidget {
  const TodoListOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final pageTitle = "Todo Listen";

    return Scaffold(
      appBar: header(colors, pageTitle),

      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Container(
          color: colors.backgroundColor,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? Todo list items
              Column(
                children: [
                ListItem(title: "Dailies", amountText: "2 Tasks"),
                ListItem(title: "Todo App", amountText: "5 Tasks"),
                ListItem(title: "Home Server", amountText: "1 Tasks"),
                ListItem(title: "Home Server", amountText: "1 Tasks"),
                ListItem(title: "Home Server", amountText: "1 Tasks"),
                ListItem(title: "Home Server", amountText: "1 Tasks"),
                ],
              ),

              //? Bottom part
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: NavCircle(selectedPage: SelectedPage.todo,),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.secondBackgroundColor,
        shape: CircleBorder(),
        onPressed: () {

        },
        child: Icon(
          Icons.add,
          color: colors.textColor,
          size: 40,
        ),
      )
    );
  }
}
