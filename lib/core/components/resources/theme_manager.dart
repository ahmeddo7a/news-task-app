import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData lightTheme(){
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.white,
      elevation: 1,
      titleTextStyle:  TextStyle(
        color: ColorManager.blackSemi,
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
    ),
    scaffoldBackgroundColor: ColorManager.white,
    textTheme: const TextTheme(

    ),
  );
}