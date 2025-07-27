import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/textfield.dart';
import 'package:todo_app_frontend/main.dart';


class ThreeDotsMenuButton extends StatelessWidget {
  final Function(BuildContext context) onPressed;


  const ThreeDotsMenuButton({
    super.key, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      width: 20.0,
      child: IconButton(
        padding: EdgeInsets.all(0),
        onPressed: () => onPressed(context), icon: 
          Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 20
        )
      ),
    );
  }
}


class ThreeDotsMenu<T> extends StatelessWidget {
  final T listItem;
  final Function(T listItem) deleteFunction;
  final Function setTitleFieldEnabled;

  const ThreeDotsMenu({
    super.key,
    required this.listItem,
    required this.deleteFunction,
    required this.setTitleFieldEnabled
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //? Edit
        GestureDetector(
          onTap: () {
            setTitleFieldEnabled();
            Navigator.of(context).pop();
          },

          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: colors.textColor,
                    size: 20,
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(content: "Edit", fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),

        //? Delete
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            deleteFunction(listItem);
          },

          child: Container(
            color: Colors.transparent,
            
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: colors.textColor,
                    size: 20,
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(content: "Delete", fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
