import 'package:flutter/material.dart';
import 'package:todo_app_frontend/main.dart';

class Textfield extends StatelessWidget {
  final String content;
  final double fontSize;

  const Textfield({
    super.key,
    required this.content,
    required this.fontSize
    });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DefaultTextStyle(
      style: TextStyle(),
        child: Text(
        content,
        style: TextStyle(
          color: colors.textColor,
          fontSize: fontSize
        )
      )
    );
  }
}
