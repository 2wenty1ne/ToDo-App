import 'package:flutter/material.dart';
import 'package:todo_app_frontend/main.dart';

enum SelectedPage { todo, shop, search, settings }

class NavCircle extends StatefulWidget {
  final SelectedPage selectedPage;

  const NavCircle({
      super.key,
      required this.selectedPage,
    });

  @override
  State<NavCircle> createState() => _NavCircleState();
}

class _NavCircleState extends State<NavCircle> {
  bool _isExpanded = false;

  void _changeOpenState() {
    setState(() {
      if (_isExpanded) {
        _isExpanded = false;
      } else {
        _isExpanded = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    const double iconPadding = 4;

    var selectedBackgroundColor = colors.textColor;
    var selectedIconColor = colors.selectionColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 24),
      child: closedNavCircle(colors, iconPadding, selectedBackgroundColor, selectedIconColor),
    );

    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 10, left: 24),
    //   child: 
    //   // _isExpanded ? closedNavCircle(colors, iconPadding, selectedBackgroundColor, selectedIconColor):

    //   AnimatedContainer(
    //     duration: Duration(milliseconds: 300),
    //     width: _isExpanded ? 210 : 80,
    //     height: 80,
    //     decoration: BoxDecoration(
    //       color: colors.secondBackgroundColor,
    //       shape: BoxShape.circle,
    //     ),

    //     child: Row(
    //       children: [
    //         //? Closed Nav Circle
    //         _isExpanded
    //         ? closed(colors, iconPadding, selectedBackgroundColor, selectedIconColor)
    //         :Expanded(
    //           child: closed(colors, iconPadding, selectedBackgroundColor, selectedIconColor),
    //         ),

    //         AnimatedSlide(
    //           offset: _isExpanded ? Offset.zero : Offset(1, 0),
    //           duration: Duration(milliseconds: 300),
              
    //           child: 
    //           _isExpanded
    //           ?Expanded(
    //             child: opened(colors),
    //           )
    //           :opened(colors)
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }


  Visibility opened(ColorScheme colors) {
    return Visibility(
      visible: _isExpanded ? true : false,
      child: Row(
        children: [
          navIcon(Icons.check_circle_outline, colors.textColor),
          navIcon(Icons.shopping_cart, colors.textColor),
          navIcon(Icons.search, colors.textColor),
          navIcon(Icons.settings, colors.textColor),
        ],
      ),
    );
  }


  GestureDetector closed(ColorScheme colors, double iconPadding, Color selectedBackgroundColor, Color selectedIconColor) {
    return GestureDetector(
      onTap: () => setState(() => _changeOpenState()),
      child: closedInnerNav(colors, iconPadding, selectedBackgroundColor, selectedIconColor),
    );
  }


Visibility closedInnerNav(ColorScheme colors, double iconPadding, Color selectedBackgroundColor, Color selectedIconColor) {
  return Visibility(
    visible: _isExpanded ? false : true,
    child: Stack(
        children: [
    
          //? Todo Icon
          Padding(
            padding: EdgeInsets.only(top: iconPadding),
            child: Align(
              alignment: Alignment.topCenter,
    
              child: 
              (widget.selectedPage == SelectedPage.todo) ?
              selectedIcon(Icons.check_circle_outline, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.check_circle_outline, colors.textColor),
            ),
          ),
    
          //? Shopping Icon
          Padding(
            padding: EdgeInsets.only(left: iconPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: 
              (widget.selectedPage == SelectedPage.shop) ?
              selectedIcon(Icons.shopping_cart, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.shopping_cart, colors.textColor),
            ),
          ),
    
          //? Search Icon
          Padding(
            padding: EdgeInsets.only(right: iconPadding),
            child: Align(
              alignment: Alignment.centerRight,
              child:
              (widget.selectedPage == SelectedPage.search) ?
              selectedIcon(Icons.search, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.search, colors.textColor),
            ),
          ),
    
          //? Settings Icon
          Padding(
            padding: EdgeInsets.only(bottom: iconPadding),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: 
              (widget.selectedPage == SelectedPage.settings) ?
              selectedIcon(Icons.settings, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.settings, colors.textColor),
            ),
          )
        ],
      ),
  );
}


//? Code befor animation
  Container closedNavCircle(ColorScheme colors, double iconPadding, Color selectedBackgroundColor, Color selectedIconColor) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: colors.secondBackgroundColor,
        shape: BoxShape.circle,
      ),
    
      child: Stack(
        children: [

          //? Todo Icon
          Padding(
            padding: EdgeInsets.only(top: iconPadding),
            child: Align(
              alignment: Alignment.topCenter,

              child: 
              (widget.selectedPage == SelectedPage.todo) ?
              selectedIcon(Icons.check_circle_outline, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.check_circle_outline, colors.textColor),
            ),
          ),

          //? Shopping Icon
          Padding(
            padding: EdgeInsets.only(left: iconPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: 
              (widget.selectedPage == SelectedPage.shop) ?
              selectedIcon(Icons.shopping_cart, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.shopping_cart, colors.textColor),
            ),
          ),

          //? Search Icon
          Padding(
            padding: EdgeInsets.only(right: iconPadding),
            child: Align(
              alignment: Alignment.centerRight,
              child:
              (widget.selectedPage == SelectedPage.search) ?
              selectedIcon(Icons.search, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.search, colors.textColor),
            ),
          ),

          //? Settings Icon
          Padding(
            padding: EdgeInsets.only(bottom: iconPadding),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: 
              (widget.selectedPage == SelectedPage.settings) ?
              selectedIcon(Icons.settings, selectedBackgroundColor, selectedIconColor):
              navIcon(Icons.settings, colors.textColor),
            ),
          )
        ],
      )
    );
  }
}


Container selectedIcon(IconData icon, Color selectedBackgroundColor, Color selectedIconColor) {
  const double size = 29;

  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: selectedBackgroundColor,
      shape: BoxShape.circle, 
    ),
    child: Center(
      child: 
      navIcon(icon, selectedIconColor)
    )
  );
}


Icon navIcon(IconData icon, Color iconColor) {
  return Icon (
      icon,
      color: iconColor,
      size: 23,
  );
}
