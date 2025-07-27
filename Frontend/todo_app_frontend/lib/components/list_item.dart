import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:todo_app_frontend/components/textfield.dart';
import 'package:todo_app_frontend/components/three_dot_menu.dart';
import 'package:todo_app_frontend/main.dart';
import 'package:todo_app_frontend/models/list_item_interface.dart';


class ListItem<T extends ListableItem> extends StatefulWidget {
  final String amountText;
  final T listItem;
  final Function(T listItem) deleteFunction;
  final Function(T listItem, String newTitle) updateFunction;
  final Function (BuildContext conext, T listItem) nextPageFunction;

  const ListItem({
    super.key,
    this.amountText = "",
    required this.listItem,
    required this.deleteFunction,
    required this.updateFunction,
    required this.nextPageFunction,
  });

  @override
  State<ListItem<T>> createState() => _ListItemState<T>();
}

class _ListItemState<T extends ListableItem> extends State<ListItem<T>> {

  late bool titleFieldEnabled;
  late FocusNode titleFieldFocusNode;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();

    titleFieldEnabled = widget.listItem.getInitialStatus();

    titleFieldFocusNode = FocusNode();
    titleController = TextEditingController(text: widget.listItem.title);
  }

  @override
  void dispose() {
    titleFieldFocusNode.dispose();
    titleController.dispose();
    super.dispose();
  }


  void setTitleFieldEnabled() {
    setState(() {
      titleFieldEnabled = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      titleFieldFocusNode.requestFocus();

      titleController.selection = TextSelection(
        baseOffset: 0, 
        extentOffset: titleController.text.length
      );
    });
  }


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
                      Icons.drag_indicator,
                      color: Colors.black,
                      size: 20
                    ),
                  ),
                ),

              //? Middle Text
              titleFieldEnabled
              ? middleText(colors)

              : GestureDetector(
                onTap: () {
                  widget.nextPageFunction(context, widget.listItem);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: ((context) => TodoListPage(todoList: widget.listItem,))
                  //   )
                  // );
                },

                child: Container(
                  color: Colors.transparent,
                
                  child: middleText(colors),
                ),
              ),
            ],
          ),

          //? Back Button + 3-Dot-Menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: colors.textColor,
                  size: 28
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 18, right: 8),
                child: ThreeDotsMenuButton(

                  onPressed: (context) {
                    showPopover(
                      context: context, 
                      bodyBuilder: (context) => ThreeDotsMenu(
                        listItem: widget.listItem,
                        deleteFunction: widget.deleteFunction,
                        setTitleFieldEnabled: setTitleFieldEnabled,
                      ),
                      width: 100,
                      height: 80,
                      backgroundColor: colors.backgroundColor,
                      direction: PopoverDirection.left,
                      arrowHeight: 15,
                      arrowWidth: 30,
                    );
                  },
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  Column middleText(ColorScheme colors) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                
                  children: [
                    // ? SizedBox(
                    SizedBox(
                      width: 240,
                      height: 30,
                      child: 
                      titleFieldEnabled
                      //? Editing Text
                      ? TextField(
                        controller: titleController,
                        focusNode: titleFieldFocusNode,
                        autofocus: true,
                
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 2),
                          isDense: true,
                        ),
                
                        style: TextStyle(
                          color: colors.editingTextColor,
                          fontSize: 20,
                          height: 1.0,
                        ),
                      
                        onSubmitted: (value) {
                          widget.updateFunction(widget.listItem, value);
                          setState(() => titleFieldEnabled = false);
                        },
                        
                        onTapOutside: (_) {
                          titleController.text = widget.listItem.title;
                          setState(() => titleFieldEnabled = false);
                        },
                      )
                
                      //? Normnal Text
                      : CustomText(content: widget.listItem.title, fontSize: 20,),
                    ),
                    
                    //? Subtext
                    // CustomText(content: widget.amountText, fontSize: 14)
                    Text(
                      widget.amountText,
                      style: TextStyle(
                        color: colors.subTextColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
  }
}
