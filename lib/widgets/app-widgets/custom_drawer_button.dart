import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  CustomDrawerButton({
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Colors.grey[800] : Colors.blue;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 7),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // цвет кнопки
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          textStyle: GoogleFonts.nunito(fontSize: 18, color: Colors.white),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              SizedBox(width: 10), // отступ между иконкой и текстом
            ],
            Text(text, style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
