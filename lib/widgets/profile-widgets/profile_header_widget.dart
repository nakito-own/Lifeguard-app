import 'package:flutter/material.dart';


class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key,
    required this.FirstName,
    required this.SecondName,
    required this.Patronymic,
    required this.Post1,
    required this.Post2}) : super(key: key);
  final String FirstName;
  final String SecondName;
  final String Patronymic;
  final String Post1;
  final String Post2;

  @override
  Widget build(BuildContext context) {

    String EmptyText = ' ';

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text (
            SecondName + EmptyText + FirstName + EmptyText + Patronymic,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text (
            Post1,
            style:  TextStyle(
              fontSize: 16,
              color: Color(0xff4eab2c),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            Post2,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff4eab2c),
            ),
          )
        ],
      ),
    );
  }
}