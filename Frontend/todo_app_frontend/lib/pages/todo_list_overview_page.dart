import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_frontend/components/footer.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/components/list_item.dart';
import 'package:todo_app_frontend/components/nav_circle.dart';
import 'package:todo_app_frontend/main.dart';
import 'package:todo_app_frontend/models/list_item_interface.dart';
import 'package:todo_app_frontend/models/todo_list_model.dart';
import 'package:todo_app_frontend/pages/todo_list_page.dart';
import 'package:todo_app_frontend/providers/todo_app_provider.dart';

class TodoListOverviewPage extends StatefulWidget {
  final List<TodoList> todolists = [];

  TodoListOverviewPage({super.key});

  @override
  TodoListOverviewPageState createState() => TodoListOverviewPageState();
}


class TodoListOverviewPageState extends State<TodoListOverviewPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoAppProvider>().loadAllTodoLists();
    });
  }


  void nextPageFunction(BuildContext context, ListableItem listItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => TodoListPage(todoList: (listItem as TodoList)))
      )
    );
  }


  void createTodoListFunction(BuildContext context) {
    context.read<TodoAppProvider>().createTodoList();
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final pageTitle = "Todo Lists";

    return Scaffold(
      appBar: header(colors, pageTitle, context),

      body: Consumer<TodoAppProvider>(
        builder: (context, provider, child) {
          final todoLists = provider.todoLists;
        
          return Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Container(
              color: colors.backgroundColor,
          
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? Todo list items
                  Column(
                    children: todoLists.map((todoList) => 
                      ListItem<TodoList>(
                        amountText: "0 Tasks", 
                        listItem: todoList, 
                        deleteFunction: provider.deleteTodoList,
                        updateFunction: provider.updateTodoList,
                        nextPageFunction: nextPageFunction,
                      )
                    ).toList()
                  ),
          
                  //? Bottom part
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: NavCircle(selectedPage: SelectedPage.todo,),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: floatingActionButton(colors, context, createTodoListFunction)
    );
  }


}
