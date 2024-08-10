import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key,
    required this.FirstName,
    required this.SecondName,
    required this.Patronymic}) : super(key: key);
  final String FirstName;
  final String SecondName;
  final String Patronymic;

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
            "Role",
            style:  TextStyle(
              fontSize: 16,
              color: Color(0xff4eab2c),
            ),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}