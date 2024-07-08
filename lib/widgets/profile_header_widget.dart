import 'package:flutter/material.dart';


class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key,
    required this.text1,
    required this.text2,
    required this.text3}) : super(key: key);
  final String text1;
  final String text2;
  final String text3;
  

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme
        .of(context)
        .brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);


    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            CircleAvatar(
              radius: 55,
            backgroundImage: NetworkImage('https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200')
            ),
            SizedBox(
              height: 10,
            ),
            Text (
              text1,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text (
              text2,
              style:  TextStyle(
                fontSize: 18,
                color: Color(0xff4eab2c),
              ),
            ),
          SizedBox(
            height: 2,
          ),
          Text(
            text3,
            style: TextStyle(
              fontSize: 18,
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