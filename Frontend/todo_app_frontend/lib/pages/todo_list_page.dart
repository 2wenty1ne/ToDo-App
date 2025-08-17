import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_frontend/components/footer.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/components/listItems/list_item.dart';
import 'package:todo_app_frontend/components/nav_circle.dart';
import 'package:todo_app_frontend/main.dart';
import 'package:todo_app_frontend/models/list_item_interface.dart';
import 'package:todo_app_frontend/models/todo_list_model.dart';
import 'package:todo_app_frontend/models/todo_model.dart';
import 'package:todo_app_frontend/pages/todo_page.dart';
import 'package:todo_app_frontend/providers/todo_app_provider.dart';


class TodoListPage extends StatefulWidget {
  final TodoList todoList;

  const TodoListPage({
      super.key,
      required this.todoList,
    });

  @override
  State<TodoListPage> createState() => TodoListPageState();
}


class TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoAppProvider>().loadAllTodos(widget.todoList);
    });
  }


  void nextPageFunction(BuildContext context, ListableItem todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => TodoPage(todo: todo as Todo,))
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;    

    return Scaffold(
      appBar: header(colors, widget.todoList.title, context, true),

      body: Consumer<TodoAppProvider>(
        builder: (context, provider, child) {
          final todos = provider.todos;

          return Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.vertInset, 
              AppDimensions.topBodyInset, 
              AppDimensions.vertInset, 
              0
            ),
            child: Container(
              color: colors.backgroundColor,

              //? Actual body
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Column(
                    children: todos.map((todo) =>

                      ListItem<Todo>(
                        amountText: "0 Subtasks",
                        listItem: todo,
                        deleteFunction: provider.deleteTodo,

                        updateFunction: (Todo todo, dynamic newCompleted) {
                          provider.updateTodo(todo, todo.title, todo.description, newCompleted);
                        },

                        nextPageFunction: nextPageFunction,
                      ),
                    ).toList()
                  ),
                  
                  //? Bottom part
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: NavCircle(selectedPage: SelectedPage.todo,),
                  ),
                ],
              ),
            )
          );
        },
      ),
      floatingActionButton: floatingActionButton(colors, () {
        context.read<TodoAppProvider>().createTodo(widget.todoList.id);
      }),
    );
  }
}
