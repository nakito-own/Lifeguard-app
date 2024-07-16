import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";

class MyInfo extends StatelessWidget {
  const MyInfo({Key? key,
    required this.phone,
    required this.VK_Link,
    required this.TG_Link,
    required this.Mail_Link,
    //required this.toggleTheme
    }) : super(key: key);

  //final VoidCallback toggleTheme;
  final String phone;
  final String VK_Link;
  final String TG_Link;
  final String Mail_Link;

  LinkToVK() async {
    final Uri url = Uri.parse(VK_Link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }
  LinkToTG() async {
    final Uri url = Uri.parse(TG_Link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }
  LinkToMail() async {
    final Uri url = Uri.parse(Mail_Link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }


  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);
    final border_Color = isDarkTheme ? Color(0xff383434) : Color(0xffc8cccc);
    final text_Color = isDarkTheme ? Colors.white : Colors.black;

    return Container(
      height: 175,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.fromLTRB(4,5,4,20),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        /* color: Color(0xff2d2a2a),*/
        color: buttonColor,
        border: Border.all(
            color: border_Color,
              /*color: Color(0xff383434),*/
            width: 2
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Телефон:  ',
                style: TextStyle(fontSize: 19, height: 1.5, color: text_Color),
              ),
              TextSpan(
                text:phone,
                style: TextStyle(fontSize: 18, color: text_Color),
              ),
              TextSpan(
                text: '\n VK:  ',
                style: TextStyle(fontSize: 19, height: 2, color: text_Color),
              ),
              TextSpan(
                text: VK_Link,
                style: const TextStyle(color: Colors.blue, fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap =LinkToVK,
              ),
              TextSpan(
                text: '\n TG:  ',
                style: TextStyle(fontSize: 19, height: 2,color: text_Color),
              ),
              TextSpan(
                text: TG_Link,
                style: const TextStyle(color: Colors.blue, fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap =LinkToTG,
              ),
              TextSpan(
                text: '\n Почта:  ',
                style: TextStyle(fontSize: 19, height: 2, color: text_Color),
              ),
              TextSpan(
                  text: Mail_Link,
                  style: const TextStyle(color: Colors.blue, fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = LinkToMail,
              ),
            ]
    ),
      ),
        ],
      ),
    );
  }
}

