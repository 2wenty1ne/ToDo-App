import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_frontend/components/header.dart';
import 'package:todo_app_frontend/components/three_dot_menu.dart';
import 'package:todo_app_frontend/main.dart';
import 'package:todo_app_frontend/models/todo_model.dart';
import 'package:todo_app_frontend/providers/todo_app_provider.dart';

class TodoPage extends StatefulWidget {
  final Todo todo;

  const TodoPage({
    super.key,
    required this.todo
  });

  @override
  State<TodoPage> createState() => _TodoPage();
}

class _TodoPage extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme; 
    return Scaffold(
      appBar: header(colors, "", context, true),

      body: Consumer<TodoAppProvider>(
        builder: (context, provider, child) {
          
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
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  //? Title Row
                  Row(
                  
                    children: [
                      //? Button + Title
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {}, 
                            icon: Icon(
                              widget.todo.completed ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                              color: colors.textColor,
                              size: 35
                            ),
                          ),
                      
                          Text(
                            widget.todo.title,
                            style: TextStyle(
                              color: colors.textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),

                      IconButton(
                        onPressed: () {
                          showPopover(
                            context: context, 
                            bodyBuilder: (context) => ThreeDotsMenu(
                              listItem: listItem, 
                              deleteFunction: deleteFunction, 
                              setTitleFieldEnabled: setTitleFieldEnabled)
                          )
                        }, 
                        icon: icon
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}