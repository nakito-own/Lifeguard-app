import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.fromLTRB(4,4,4,20),
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: buttonColor,
      ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text (
          'In Dev',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    ),
    );
  }
}
