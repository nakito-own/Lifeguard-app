import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class CustomButtonPush extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  void printOne() {
    print('1');
  }

  CustomButtonPush({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Colors.grey[800] : Colors.blue;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
     /* child: Column(
        mainAxisSize: MainAxisSize.min,*/
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe0882c)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all<Color>(Color(0xff201a1a)),
              shadowColor: MaterialStateProperty.all<Color>(Color(0xff808080)),
              //shadowColor: MaterialStateProperty.all(Colors.black38),
              elevation: MaterialStateProperty.all(8),
              //padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.9, 45)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

            ),
              onPressed: printOne,
              child: Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400 )),
          ),

      );

  }
}

/*
backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe0882c)),
foregroundColor: MaterialStateProperty.all(Colors.white),
overlayColor: MaterialStateProperty.all<Color>(Color(0xff201a1a)),
shadowColor: MaterialStateProperty.all<Color>(Color(0xff808080)),*/
