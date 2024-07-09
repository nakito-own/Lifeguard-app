import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {

  const TransparentButton({ Key? key,
    required this.text }) : super(key: key);
  final String text;

  void editing() {
    print('Скоро что-то будет');
  }

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);

    return Center(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width * 1, MediaQuery.of(context).size.height * 0.05)),

        ),
        onPressed: editing,
        child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: buttonColor, )),
      ),

    );
  }
}
