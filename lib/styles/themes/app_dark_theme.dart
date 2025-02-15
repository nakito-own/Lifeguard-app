import 'package:flutter/material.dart';

class AppDarkTheme {
  static final ThemeData darkTheme = ThemeData(
    colorSchemeSeed: Colors.grey[800],
    brightness: Brightness.dark,
    primaryColor: Colors.grey[980],
    primaryColorLight: Colors.grey[900],
    scaffoldBackgroundColor:  Colors.grey[950],
    appBarTheme: AppBarTheme(
      elevation: 6,
      shadowColor: Colors.black,
      color: Colors.grey[950],
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

