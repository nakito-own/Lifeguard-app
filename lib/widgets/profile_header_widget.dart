import 'package:flutter/material.dart';


class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key,
    required this.FIO,
    required this.Post1,
    required this.Post2}) : super(key: key);
  final String FIO;
  final String Post1;
  final String Post2;


  @override
  Widget build(BuildContext context) {




    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text (
            FIO,
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


      /*child: Container(
        width: 140,
        height: 360,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage (
            image: AssetImage ('lib/widgets/icons/Jarik.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            )
        ),

            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox (
                height: 150,
              ),
              Text (
                text1,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
            ),


        ),*/
    );

  }
}