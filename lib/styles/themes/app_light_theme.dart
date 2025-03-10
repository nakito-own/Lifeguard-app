import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLightTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: _colorScheme.surface,

    appBarTheme: AppBarTheme(
      backgroundColor: _colorScheme.surface,
      foregroundColor: _colorScheme.onPrimary,
      elevation: 8,
      shadowColor: Colors.black,
    ),
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    textButtonTheme: _textButtonTheme
  );

  static ColorScheme _colorScheme = ColorScheme.light(
    primary: Colors.grey[300]!,
    secondary: Colors.blue[800]!,
    surface: const Color(0xFFF5F5F5),
    error: const Color(0xFFD32F2F),
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
  );

  static TextTheme _textTheme = TextTheme(
    bodyLarge: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    bodyMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    displayMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
    bodySmall: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
    titleLarge: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _colorScheme.primary,
      foregroundColor: _colorScheme.onPrimary,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[800]),
      )
  );
}
