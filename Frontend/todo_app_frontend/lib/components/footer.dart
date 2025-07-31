  import 'package:flutter/material.dart';
import 'package:todo_app_frontend/main.dart';

FloatingActionButton floatingActionButton(
    ColorScheme colors, BuildContext context, Function function
  ) {
    return FloatingActionButton(
      backgroundColor: colors.secondBackgroundColor,
      shape: CircleBorder(),
      onPressed: () => function(context),
      child: Icon(
        Icons.add,
        color: colors.textColor,
        size: 40,
      ),
    );
  }