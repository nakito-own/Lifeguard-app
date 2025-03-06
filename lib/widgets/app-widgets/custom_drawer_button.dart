import 'package:flutter/material.dart';

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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          textStyle: TextTheme.of(context).bodyLarge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              SizedBox(width: 10),
            ],
            Text(text, style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
