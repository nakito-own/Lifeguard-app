import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String buttonText;
  final bool MiniButton;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.MiniButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Colors.orange[700] : Colors.blue;
    final shadowColor = isDarkTheme ? Colors.black : Colors.black;
    final buttonSize = MiniButton ? Size(160, 40) : Size(1000, 40);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          maximumSize: buttonSize,
          backgroundColor: buttonColor,
          shadowColor: shadowColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextTheme.of(context).bodyLarge
          ),
        ),
      ),
    );
  }
}
