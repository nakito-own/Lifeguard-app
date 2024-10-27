import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText({Key? key,
    required this.some_text,
    required this.Width
    ,}) : super(key: key);
  final String some_text;
  final double Width;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkTheme ? Colors.grey : Colors.black;

    return Container(
      margin: EdgeInsets.fromLTRB(21, 0, 0, 0),
      width: Width,
      child: Text(
        some_text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
        maxLines: 1,
      ),
    );
  }
}