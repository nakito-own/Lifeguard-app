import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CustomTextField extends StatefulWidget {
  CustomTextField({Key? key,
  required this.hintText,
  required this.labelText,
  required this.NewText,}) : super(key: key);
  final String hintText;
  final String labelText;
  final Function(String) NewText;


  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.clear();
    _GetText();
  }

/*  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }*/

  _GetText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _textEditingController.text = prefs.getString('savedText') ?? '';
      widget.NewText(_textEditingController.text);
    });
  }

  _setText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedText', text);
  }


  @override
  Widget build(BuildContext context) {
    return Center(

      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        height: 42,
        child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff7e7e7e),
            ) ,
            enabled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (text) {
          _setText(text);
          widget.NewText(text);
        }
        ),
      ),
    );
  }
}
