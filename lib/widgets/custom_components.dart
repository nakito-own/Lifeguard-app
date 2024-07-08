import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ButtonExit extends StatelessWidget {



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
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05)),
            ),
            onPressed: Exit,

            child: Text('Выход', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xffe91e1e), )),
          ),
        ],
      ),
    );
  }
}

