import 'package:flutter/material.dart';


class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key,
    required this.text1,
    required this.text2,}) : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);

    return Center(
      child: Container(
      alignment: Alignment.centerLeft,
      height: 158,
      width: MediaQuery.of(context).size.width * 0.92,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
       /* color: Color(0xff2d2a2a),*/
        color: buttonColor,
        border: Border.all(
          color: buttonColor,
          /*  color: Color(0xff383434), */
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
    ),
    );
  }
}
