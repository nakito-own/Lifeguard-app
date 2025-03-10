import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeguard/api-services/staff_service.dart';
import 'package:lifeguard/widgets/app-widgets/avatar_picker.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';
import '../widgets/staff-widgets/role_dropdown_widget.dart';

class CreateUserScreen extends StatefulWidget {
  CreateUserScreen({super.key});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {

  final StaffService _staffService = StaffService();
  final TextEditingController _applyController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _tgController = TextEditingController();
  final TextEditingController _vkController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _applyController.text = _dateFormat.format(picked);
      });
    }
  }

  Widget _buildCustomTextField(String label, TextEditingController controller, {bool isDate = false}) {
    return isDate
        ? GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextField(
          text: '',
          controller: controller,
          labelText: label,
          widthSize: double.infinity,
          heightSize: 70,
          icon: Icons.calendar_today,
          togglePass: () {},
          isObscured: false,
          lines: 1,
        ),
      ),
    )
        : CustomTextField(
      text: '',
      controller: controller,
      labelText: label,
      widthSize: double.infinity,
      heightSize: 60,
      icon: Icons.text_fields,
      togglePass: () {},
      isObscured: false,
      lines: 1,
    );
  }

  Future<void> _createUser() async {
    final Map<String, dynamic> userData = {
      "name": _nameController.text.trim(),
      "surname": _surnameController.text.trim(),
      "patronymic": _patronymicController.text.trim(),
      "nick": _nickController.text.trim(),
      "phone": _phoneController.text.trim(),
      "tg": _tgController.text.trim(),
      "vk": _vkController.text.trim(),
      "email": _emailController.text.trim(),
      "role": int.tryParse(_roleController.text.trim()) ?? 1,
      "apply": _applyController.text,
      "password": _passwordController.text.trim()
    };

    final response = await _staffService.createStaff(userData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] ?? 'Ошибка при создании сотрудника')),
    );

    if (response['success']) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новый сотрудник'),
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
                    AvatarPicker(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Имя Фамилия Отчество', style: TextTheme.of(context).bodySmall),
                        SizedBox(height: 5),
                        Column(
                          children: [
                            _buildCustomTextField('Имя', _nameController),
                            _buildCustomTextField('Фамилия', _surnameController),
                            _buildCustomTextField('Отчество (При наличии)', _patronymicController),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Основная информация', style: TextTheme.of(context).bodySmall),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCustomTextField('Дата заступления на службу', _applyController, isDate: true),
                            _buildCustomTextField('Email', _emailController),
                            _buildCustomTextField('Позывной', _nickController),
                            RoleDropdown(controller: _roleController),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Контактная информация', style: TextTheme.of(context).bodySmall),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCustomTextField('Телефон (обязательно)', _phoneController),
                            _buildCustomTextField('Telegram (Опционально)', _tgController),
                            _buildCustomTextField('ВК (Опционально)', _vkController),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    _buildCustomTextField('Пароль', _passwordController),
                    SizedBox(height: 15),
                    CustomButton(
                      buttonText: 'Создать',
                      onPressed: _createUser,
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
