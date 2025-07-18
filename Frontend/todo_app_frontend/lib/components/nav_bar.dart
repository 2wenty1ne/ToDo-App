import 'package:flutter/material.dart';
import 'package:todo_app_frontend/main.dart';


class NavCircle extends StatelessWidget {
  const NavCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: colors.secondBackgroundColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
