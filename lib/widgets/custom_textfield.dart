import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;


class CustomTextfield extends StatelessWidget {

  final String InputString = " ";
  const CustomTextfield({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Логин',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff7e7e7e),
            ) ,
            enabled: true,
            contentPadding: EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color(0xff7e7e7e),
                  width: 2,
                ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xff7e7e7e),
                width: 2,
              ),
            ),

          ),
        ),
      ),
    );
  }
}

class CustomTextfieldPassword extends StatelessWidget {
  const CustomTextfieldPassword({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Пароль',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff7e7e7e),
            ) ,
            enabled: true,
            contentPadding: EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xff7e7e7e),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xff7e7e7e),
                width: 2,
              ),
            ),

          ),
        ),
      ),
    );
  }
}