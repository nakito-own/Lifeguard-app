import 'package:flutter/material.dart';



class AppDarkTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[980],
    scaffoldBackgroundColor:  Colors.grey[980],
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

