import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/widgets.dart';



class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key,
    required this.text1,
    required this.text2}) : super(key: key);
  final String text1;
  final String text2;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.21,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xff2d2a2a),
        border: Border.all(
            color: Color(0xff383434),
            width: 2
        ),
      ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text (
          'Закреплённые группы:',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
        text1,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
        SizedBox(
          height: 20,
        ),
        Text (
          'Класс спасателя:',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text (
          text2,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff4fac2e),
          ),
        ),
      ],
    ),
    );
  }
}
