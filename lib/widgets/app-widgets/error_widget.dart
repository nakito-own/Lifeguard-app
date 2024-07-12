import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';

class ErrorAlertDialog extends StatelessWidget {
  final VoidCallback toggleTheme;
  final String errorMessage;

  ErrorAlertDialog({
    required this.errorMessage,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final widgetColor = isDarkTheme ? Colors.grey[900] : Colors.white;

    return AlertDialog(
      backgroundColor: widgetColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            errorMessage,
            style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
          ),
          SizedBox(height: 20),
          CustomButton(
            buttonText: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
            },
            MiniButton: true,
          ),
        ],
      ),
    );
  }
}
