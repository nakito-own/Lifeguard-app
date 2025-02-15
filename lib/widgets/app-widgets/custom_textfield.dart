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
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1400),
        child: SizedBox(
          width: widget.widthSize,
          height: widget.heightSize,
          child: TextField(
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
              hintText: widget.text,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff7e7e7e),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                  width: 2,
                ),
              ),
            ),
            onChanged: (text) {
              _setText(text);
            },
          ),
        ),
      ),
    );
  }
}
