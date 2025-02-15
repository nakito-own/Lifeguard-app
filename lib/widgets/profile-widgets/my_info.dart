import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeguard/widgets/app-widgets/small_text.dart';
import "package:url_launcher/url_launcher.dart";

class MyInfo extends StatelessWidget {
  const MyInfo({Key? key,
    required this.phone,
    required this.VK_Link,
    required this.TG_Link,
    required this.Mail_Link,
    //required this.toggleTheme
    }) : super(key: key);

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
    final text_Color = isDarkTheme ? Colors.white : Colors.black;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 1200
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText(some_text: 'Личные данные', Width: double.infinity),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).primaryColorLight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Телефон:  ',
                      style: GoogleFonts.nunito(fontSize: 19, height: 1.5, color: text_Color),
                    ),
                    TextSpan(
                      text:phone,
                      style: GoogleFonts.nunito(fontSize: 18, color: text_Color),
                    ),
                    TextSpan(
                      text: '\nVK:  ',
                      style: GoogleFonts.nunito(fontSize: 19, height: 2, color: text_Color),
                    ),
                    TextSpan(
                      text: VK_Link,
                      style: GoogleFonts.nunito(color: Colors.blue, fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap =LinkToVK,
                    ),
                    TextSpan(
                      text: '\nTG:  ',
                      style: GoogleFonts.nunito(fontSize: 19, height: 2,color: text_Color),
                    ),
                    TextSpan(
                      text: TG_Link,
                      style: GoogleFonts.nunito(color: Colors.blue, fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap =LinkToTG,
                    ),
                    TextSpan(
                      text: '\nПочта:  ',
                      style: GoogleFonts.nunito(fontSize: 19, height: 2, color: text_Color),
                    ),
                    TextSpan(
                        text: Mail_Link,
                        style: GoogleFonts.nunito(color: Colors.blue, fontSize: 18,
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
          ),
        ],
      ),
    );
  }
}

