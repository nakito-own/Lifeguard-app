import 'package:flutter/material.dart';


class ButtonExit extends StatelessWidget {

  const ButtonExit({ Key? key,
    required this.text }) : super(key: key);
  final String text;

  void Exit() {
    print('Exit');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05)),
            ),
            onPressed: Exit,

            child: Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xffe91e1e), )),
          ),
        ],
      ),
    );
  }
}

