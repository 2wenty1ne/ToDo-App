import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/textfield.dart';
import 'package:todo_app_frontend/main.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String amountText;

  const ListItem({
    super.key,
    required this.title,
    this.amountText = "",
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(24, 0, 24, 15),
      decoration: BoxDecoration(
        color: colors.secondBackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //? Front Drag-Icon + Text
          Row(
            children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Icon( 
                      // Icons.drag_handle,
                      Icons.drag_indicator,
                      color: Colors.black,
                      size: 20
                    ),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(content: title, fontSize: 20,),
                  CustomText(content: amountText, fontSize: 14)
                ],
              )
            ],
          ),

          //? Back Button + 3-Dot-Menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: colors.textColor,
                  size: 28
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,0,5,18),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                  size: 20
                ),
                )
            ],
          ),
        ],
      )
    );
  }
}
