import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';

class InventoryEditing extends StatefulWidget {
  InventoryEditing({Key? key,
    required this.ItemName,
    required this.GroupNamecontroller,
    required this.ItemNamecontroller,
    required this.Descriptioncontroller,
    required this. currentQuantity,
    required this.onPressed,
  }) : super(key: key);
    final String ItemName;
    final TextEditingController GroupNamecontroller;
    final TextEditingController ItemNamecontroller;
    final TextEditingController Descriptioncontroller;
    final String currentQuantity;
    final Function(String) onPressed;

  @override
  _InventoryEditingState createState() => _InventoryEditingState();
}

class _InventoryEditingState extends State<InventoryEditing> {
  bool isObscured = true;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentQuantity);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final text_Color = isDarkTheme ? Colors.black : Colors.white;
    final container_Color = isDarkTheme ? Colors.orange[500] : Color(0xffc6c7c7);


    return SingleChildScrollView(
      child:
      AlertDialog(
       titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
       insetPadding: EdgeInsets.fromLTRB(40,100,40,70),
       contentPadding: EdgeInsets.fromLTRB(35, 0, 35, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(30))),
       title:
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: container_Color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(100)),
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text('Редактирование', style: TextStyle(fontSize: 20, color: text_Color, fontWeight: FontWeight.w600),),
          ]
        ),
      ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              CustomTextField(
                  text: '',
                  lines: 1,
                  controller: widget.GroupNamecontroller,
                  labelText: 'Группа предмета',
                  widthSize: 300,
                  heightSize: 42,
                  icon: Icon(Icons.hourglass_empty, color: Colors.transparent,),
                  togglePass: () {
                    setState(() {
                      isObscured =isObscured;
                    });
                  },
                  isObscured: isObscured,),
              SizedBox(height: 20,),
              CustomTextField(
                  text: '',
                  lines: 1,
                  controller: widget.ItemNamecontroller,
                  labelText: 'Название предмета',
                  widthSize: 300,
                  heightSize: 42,
                  icon: Icon(Icons.hourglass_empty, color: Colors.transparent,),
                  togglePass: () {
                    setState(() {
                      isObscured =isObscured;
                    });
                  },
                  isObscured: isObscured),
              SizedBox(height: 20,),
              CustomTextField(
                  text: '',
                  lines: 4,
                  controller: widget.Descriptioncontroller,
                  labelText: 'Описание',
                  widthSize: 300,
                  heightSize: 100,
                  icon: Icon(Icons.hourglass_empty, color: Colors.transparent,),
                  togglePass: () {
                    setState(() {
                      isObscured =isObscured;
                    });
                  },
                  isObscured: isObscured),
              SizedBox(height: 30,),
              CustomButton(
                  buttonText: 'Сохранить',
                  onPressed: () {
                    widget.onPressed(_controller.text); // Вызываем функцию сохранения
                    Navigator.of(context).pop();
                  },
                  MiniButton: false),
              SizedBox(height: 10,),
              CustomButton(
                  buttonText: 'Отмена',
                  onPressed: () => Navigator.of(context).pop(),
                  MiniButton: false),
              SizedBox(height: 70,),
          ]
        ),


    ),
    );
  }
}