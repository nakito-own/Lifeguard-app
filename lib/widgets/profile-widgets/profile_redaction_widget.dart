import 'package:flutter/material.dart';
import 'package:lifeguard/api-services/show_staff_service.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:lifeguard/widgets/app-widgets/avatar_picker.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRedactionWidget extends StatefulWidget {
  final int staffId;
  Staff staff;

  ProfileRedactionWidget({required this.staffId, required this.staff});

  @override
  _ProfileRedactionWidgetState createState() => _ProfileRedactionWidgetState();
}

class _ProfileRedactionWidgetState extends State<ProfileRedactionWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _patronymicController;
  late final TextEditingController _phoneController;
  late final TextEditingController _vkController;
  late final TextEditingController _tgController;
  late final TextEditingController _mailController;

  final ShowStaffService _service = ShowStaffService();
  final PermissionsManager permissionsManager = PermissionsManager();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.staff.name);
    _surnameController = TextEditingController(text: widget.staff.surname);
    _patronymicController = TextEditingController(text: widget.staff.patronymic);
    _phoneController = TextEditingController(text: widget.staff.phone);
    _vkController = TextEditingController(text: widget.staff.vk);
    _tgController = TextEditingController(text: widget.staff.tg);
    _mailController = TextEditingController(text: widget.staff.email);
  }

  void _saveChanges() {
    setState(() {
      widget.staff = widget.staff.copyWith(
        newName: _nameController.text,
        newSurname: _surnameController.text,
        newPatronymic: _patronymicController.text,
        newPhone: _phoneController.text,
        newVk: _vkController.text,
        newTg: _tgController.text,
        newEmail: _mailController.text,
      );
    });

    _sendDataToServer();
  }

  Future<void> _sendDataToServer() async {
    final prefs = await SharedPreferences.getInstance();
    final String url = 'http://95.163.221.72:8000/users';
    final String? token = prefs.getString('jwt');

    final Map<String, dynamic> data = {
      'name': widget.staff.name,
      'surname': widget.staff.surname,
      'patronymic': widget.staff.patronymic,
      'phone': widget.staff.phone,
      'vk': widget.staff.vk,
      'tg': widget.staff.tg,
      'email': widget.staff.email,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'JWT': '$token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Данные успешно отправлены: ${response.body}');
        Navigator.pop(context);
      } else {
        print('Ошибка при отправке данных: ${response.statusCode}');
      }
    } catch (e) {
      print('Произошла ошибка: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _phoneController.dispose();
    _vkController.dispose();
    _tgController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    AvatarPicker(onImagePicked: (Uint8List ) {  },),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Имя Фамилия Отчество', style: TextTheme.of(context).bodySmall),
                        SizedBox(height: 5),
                        Column(
                          children: [
                            CustomTextField(
                              text: '',
                              controller: _nameController,
                              labelText: 'Имя',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.text_fields,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                            CustomTextField(
                              text: '',
                              controller: _surnameController,
                              labelText: 'Фамилия',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.text_fields,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                            CustomTextField(
                              text: '',
                              controller: _patronymicController,
                              labelText: 'Отчество (При наличии)',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.text_fields,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Контактная информация', style: TextTheme.of(context).bodySmall),
                        SizedBox(height: 5),
                        Column(
                          children: [
                            CustomTextField(
                              text: '',
                              controller: _phoneController,
                              labelText: 'Телефон (обязательно)',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.phone,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                            CustomTextField(
                              text: '',
                              controller: _vkController,
                              labelText: 'VK (Опционально)',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.link,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                            CustomTextField(
                              text: '',
                              controller: _tgController,
                              labelText: 'Telegram (Опционально)',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.send,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                            CustomTextField(
                              text: '',
                              controller: _mailController,
                              labelText: 'Email',
                              widthSize: double.infinity,
                              heightSize: 60,
                              icon: Icons.email,
                              togglePass: () {},
                              isObscured: false,
                              lines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: (){},
                        child: Text('Удалить профиль пользователя',
                            style: TextStyle(color: Colors.red)
                        )
                    ),
                    CustomButton(
                      buttonText: 'Сохранить изменения',
                      onPressed: _saveChanges,
                      MiniButton: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}