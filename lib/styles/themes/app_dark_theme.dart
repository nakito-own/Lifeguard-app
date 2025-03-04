import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDarkTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
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

  static ColorScheme _colorScheme = ColorScheme.dark(
    primary: Colors.grey[800]!,
    secondary: const Color(373333),
    surface: const Color(0xFF2B2828),
    error: const Color(0xFFCF6679),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.black,
  );

  static TextTheme _textTheme = TextTheme(
    bodyLarge: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
    bodyMedium: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70),
    bodySmall: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white60),
    titleLarge: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _colorScheme.primary,
      foregroundColor: _colorScheme.onPrimary,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}
