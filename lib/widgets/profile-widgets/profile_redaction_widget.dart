import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lifeguard/api-services/staff_service.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:lifeguard/widgets/app-widgets/avatar_picker.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';

import '../../api-services/image_service.dart';

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

  final StaffService _service = StaffService(); // Используем StaffService вместо ShowStaffService
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

    _updateStaffOnServer();
  }

  Future<void> _updateStaffOnServer() async {
    final Map<String, dynamic> data = {
      'name': widget.staff.name,
      'surname': widget.staff.surname,
      'patronymic': widget.staff.patronymic,
      'phone': widget.staff.phone,
      'vk': widget.staff.vk,
      'tg': widget.staff.tg,
      'email': widget.staff.email,
    };

    final response = await _service.updateStaff(widget.staffId, data);

    if (response['success']) {
      print('Данные успешно обновлены');
      Navigator.pop(context);
    } else {
      print('Ошибка при обновлении данных: ${response['message']}');
    }
  }

  void _deleteUser() async {
    final result = await _service.deleteStaff(widget.staffId);

    if (result['success']) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: ${result['message']}')),
      );
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
                    AvatarPicker(
                      onImagePicked: (Uint8List ) {  },
                      //initialImageFuture: ImageService().fetchImage('users', widget.staff.avatar),
                    ),
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
                        onPressed: _deleteUser,
                        child: Text('Уволить пользователя',
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
