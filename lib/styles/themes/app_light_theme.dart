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
  );

  static const ColorScheme _colorScheme = ColorScheme.light(
    primary: Colors.black12,
    secondary: Color(0xFFFFA000),
    surface: Color(0xFFF5F5F5),
    error: Color(0xFFD32F2F),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
  );

  static TextTheme _textTheme = TextTheme(
    bodyLarge: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
    bodyMedium: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
    bodySmall: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
    titleLarge: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _colorScheme.primary,
      foregroundColor: _colorScheme.onPrimary,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}
