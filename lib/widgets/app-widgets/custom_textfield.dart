import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTextField extends StatefulWidget {
   const CustomTextField({
    Key? key,
    required this.text,
    this.isPass = false,
    required this.controller,
    required this.labelText,
    required this.widthSize,
    required this.heightSize,
    required this.icon,
    required this.togglePass,
    required this.isObscured,
    required this.lines,
  }) : super(key: key);

  final double widthSize;
  final double heightSize;
  final String labelText;
  final String text;
  final bool isPass;
  final TextEditingController controller;
  final icon ;
  final VoidCallback togglePass;
  final bool isObscured;
  final int lines;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.clear();
    _GetText();
  }

  _GetText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      controller.text = prefs.getString('savedText') ?? '';
    });
  }

  _setText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedText', text);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1400,
          maxHeight: 40,
        ),
        child: TextField(
          style: TextTheme.of(context).bodyMedium,
          maxLines: widget.lines,
          controller: widget.controller,
          obscureText: widget.isPass ? widget.isObscured : false,
          decoration: InputDecoration(
            suffixIcon: widget.isPass
                ? IconButton(
              icon: Icon(widget.isObscured ? Icons.visibility : Icons.visibility_off),
              onPressed: widget.togglePass,
            )
                : null,
            labelText: widget.labelText,
            labelStyle: TextTheme.of(context).displayMedium,
            hintText: widget.text,
            hintStyle: TextTheme.of(context).bodySmall,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xff7e7e7e),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xff7e7e7e),
                width: 1,
              ),
            ),
          ),
          onChanged: (text) {
            _setText(text);
          },
        ),
      ),
    );
  }
}
