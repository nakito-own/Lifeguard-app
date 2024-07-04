import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class CustomButtonPush extends StatelessWidget {

  void printOne() {
    print('1');
  }

  void LPprint() {
    print('YOU ARE GAY, EXEXEXE');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe0882c)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all<Color>(Color(0xff201a1a)),
              shadowColor: MaterialStateProperty.all(Colors.grey),
              elevation: MaterialStateProperty.all(8),
              //padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.07)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),

            ),
              onPressed: printOne,
              onLongPress: LPprint,
              child: Text('Добавить мероприятие', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400 )),
          ),
        ],
      ),
    );
  }
}

