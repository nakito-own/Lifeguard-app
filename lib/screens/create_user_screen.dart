import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeguard/widgets/app-widgets/avatar_picker.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';
import '../widgets/staff-widgets/role_dropdown_widget.dart';

class CreateUserScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  CreateUserScreen({required this.toggleTheme});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _applyController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _tgController = TextEditingController();
  final TextEditingController _vkController = TextEditingController();
  final TextEditingController _bottomSheetController = TextEditingController();

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
      heightSize: 70,
      icon: Icons.text_fields,
      togglePass: () {},
      isObscured: false,
      lines: 1,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              _buildCustomTextField('Дополнительное поле', _bottomSheetController),
              SizedBox(height: 20),
              CustomButton(
                buttonText: 'Сохранить',
                onPressed: () {
                  Navigator.pop(context);
                },
                MiniButton: false,
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Colors.white10 : Colors.grey[200];

    return Scaffold(
      appBar: AppBar(
        title: Text('Новый сотрудник'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1400),
            child: Column(
              children: [
                AvatarPicker(),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: cardColor,
                    //boxShadow: [BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)]
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ФИО', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        _buildCustomTextField('Имя', _nameController),
                        _buildCustomTextField('Фамилия', _surnameController),
                        _buildCustomTextField('Отчество (При наличии)', _patronymicController),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Основная информация', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        _buildCustomTextField('Дата заступления на службу', _applyController, isDate: true),
                        _buildCustomTextField('Email', _emailController),
                        _buildCustomTextField('Позывной', _nickController),
                        RoleDropdown(controller: _roleController),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Контактная информация', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        _buildCustomTextField('Телефон (обязательно)', _phoneController),
                        _buildCustomTextField('Telegram (Опционально)', _tgController),
                        _buildCustomTextField('ВК (Опционально)', _vkController),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                CustomButton(
                  buttonText: 'Создать',
                  onPressed: () => _showBottomSheet(context),
                  MiniButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
