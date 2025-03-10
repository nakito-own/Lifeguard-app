import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    Key? key,
    required this.FirstName,
    required this.SecondName,
    required this.Patronymic,
  }) : super(key: key);

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
          SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(SecondName + EmptyText, style: TextTheme.of(context).bodyLarge),
              Text(FirstName + EmptyText, style: TextTheme.of(context).bodyLarge),
              Text(Patronymic, style: TextTheme.of(context).bodyLarge),
            ],
          ),
          SizedBox(height: 2),
          Text(
            "Role",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff4eab2c),
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
