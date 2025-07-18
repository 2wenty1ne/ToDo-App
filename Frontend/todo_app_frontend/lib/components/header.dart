import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/textfield.dart';
import 'package:todo_app_frontend/main.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showBackButton;


  const Header({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(title),
    //   ),
    // );

    return Container(
      color: colors.backgroundColor,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 58, top: 35),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Visibility(
            visible: showBackButton,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Container(
              padding: EdgeInsets.only(left: 24, bottom: 24),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: colors.textColor,
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
          ),

          Center(
            child: Textfield(
              content: title, fontSize: 32,
            )
          ),
        ],
      )
    );
  }
}
