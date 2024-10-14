import 'dart:math';

import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.symmetric( vertical: 20, horizontal:  20 ),
          child:
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(250, 224, 136, 44),
              maximumSize: Size( MediaQuery.of(context).size.width * 0.33, MediaQuery.of(context).size.width * 0.3),
              minimumSize: Size( MediaQuery.of(context).size.width * 0.17, MediaQuery.of(context).size.width * 0.15),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Действие при нажатии на кнопку
            },
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
        );
  }
}
