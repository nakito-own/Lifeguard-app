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
    textButtonTheme: _textButtonTheme
  );

  static ColorScheme _colorScheme = ColorScheme.dark(
    primary: Colors.grey[800]!,
    secondary: Colors.orange[800]!,
    surface: const Color(0xFF2B2828),
    error: const Color(0xFFCF6679),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.black,
  );

  static TextTheme _textTheme = TextTheme(
    bodyLarge: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    bodyMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[100]),
    bodySmall: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white60),
    displayMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[400]),
    titleLarge: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
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
      textStyle: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white60),
    )
  );
}
