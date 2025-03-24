import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Если вводится не цифра, возвращаем старое значение
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final String formatted;

    if (digitsOnly.length <= 1) {
      formatted = '+7 (${digitsOnly}';
    } else if (digitsOnly.length <= 4) {
      formatted = '+7 (${digitsOnly.substring(0, digitsOnly.length)}';
    } else if (digitsOnly.length <= 7) {
      formatted = '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, digitsOnly.length)}';
    } else if (digitsOnly.length <= 9) {
      formatted = '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, digitsOnly.length)}';
    } else {
      formatted = '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, 8)}-${digitsOnly.substring(8, digitsOnly.length > 10 ? 10 : digitsOnly.length)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

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
    this.isPhoneNumber = false,
  }) : super(key: key);

  final double widthSize;
  final double heightSize;
  final String labelText;
  final String text;
  final bool isPass;
  final TextEditingController controller;
  final icon;
  final VoidCallback togglePass;
  final bool isObscured;
  final int lines;
  final bool isPhoneNumber;

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
    if (widget.isPhoneNumber && widget.controller.text.isEmpty) {
      widget.controller.text = '+7 ';
    }
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
      child: SizedBox(
        width: widget.widthSize,
        height: widget.heightSize,
        child: TextField(
          maxLines: widget.lines,
          controller: widget.controller,
          obscureText: widget.isPass ? widget.isObscured : false,
          inputFormatters: widget.isPhoneNumber 
            ? [PhoneNumberFormatter()]
            : null,
          keyboardType: widget.isPhoneNumber 
            ? TextInputType.phone 
            : TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: widget.isPass ?
              IconButton(
                icon: Icon(widget.isObscured ? Icons.visibility : Icons.visibility_off),
                onPressed: widget.togglePass,
              ) : null,
            labelText: widget.labelText,
            hintText: widget.text,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff7e7e7e),
            ),
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
          }
        ),
      ),
    );
  }
}
