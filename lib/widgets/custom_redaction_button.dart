import 'package:flutter/material.dart';

class CustomRedactionButton extends StatelessWidget {
  final String redactionText;
  final VoidCallback onPressed;

  const CustomRedactionButton({
    Key? key,
    required this.redactionText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Colors.grey[800] : Colors.blue;
    final shadowColor = isDarkTheme ? Colors.black : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12, vertical: 0),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.11),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40),
          minimumSize: Size(1, 40),
          backgroundColor: buttonColor,
          shadowColor: shadowColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            redactionText,
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
