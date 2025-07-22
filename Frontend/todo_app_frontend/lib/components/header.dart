import 'package:flutter/material.dart';
import 'package:todo_app_frontend/components/textfield.dart';
import 'package:todo_app_frontend/main.dart';

AppBar header(ColorScheme colors, String pageTitle, [bool showBackButton = false]) {
  return AppBar(
    backgroundColor: colors.backgroundColor,
    toolbarHeight: 80,
    title: CustomText(content: pageTitle, fontSize: 32),
    centerTitle: true,
    //? Gesture detection für event handler?
    leading: showBackButton
      ? Icon(
        Icons.arrow_back_ios,
        color: colors.textColor,
        size: 28,
    ) : null,
  );
}
