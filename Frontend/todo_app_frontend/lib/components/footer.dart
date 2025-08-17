  import 'package:flutter/material.dart';
import 'package:todo_app_frontend/main.dart';

FloatingActionButton floatingActionButton(
    ColorScheme colors, 
    VoidCallback onPressed
  ) {
    return FloatingActionButton(
      backgroundColor: colors.secondBackgroundColor,
      shape: CircleBorder(),
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: colors.textColor,
        size: 40,
      ),
    );
  }