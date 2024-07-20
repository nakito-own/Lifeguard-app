import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key,
    required this.GroupNumber,
    required this.Position, required this.Role, required this.Another}) : super(key: key);
  final String GroupNumber;
  final String Position;
  final String Role;
  final String Another;



  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);
    final border_Color = isDarkTheme ? Color(0xff383434) : Color(0xffc8cccc);

    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.fromLTRB(4,5,4,20),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
       /* color: Color(0xff2d2a2a),*/
        color: buttonColor,
        border: Border.all(
          color: border_Color,
          /*  color: Color(0xff383434), */
            width: 2
        ),
      ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text (
          Role,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
        GroupNumber,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
        SizedBox(
          height: 10,
        ),
        Text (
          Another,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text (
          Position,
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
