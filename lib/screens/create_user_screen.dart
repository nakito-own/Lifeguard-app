import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';

class CreateUserScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  CreateUserScreen({required this.toggleTheme});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _applyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
        _applyController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget _buildCustomTextField(String label, TextEditingController controller, {bool isDate = false}) {
    return CustomTextField(
      text: '',
      controller: controller,
      labelText: label,
      widthSize: double.infinity,
      heightSize: 70,
      icon: isDate ? Icons.calendar_today : Icons.text_fields,
      togglePass: isDate ? () => _selectDate(context) : () {},
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Новый сотрудник'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            _buildCustomTextField('Дата приема', _applyController, isDate: true),
            _buildCustomTextField('Email', _emailController),
            _buildCustomTextField('Имя', _nameController),
            _buildCustomTextField('Позывной', _nickController),
            _buildCustomTextField('Отчество (При наличии)', _patronymicController),
            _buildCustomTextField('Телефон', _phoneController),
            _buildCustomTextField('Фамилия', _surnameController),
            _buildCustomTextField('Telegram (Опционально)', _tgController),
            _buildCustomTextField('ВК (Опционально)', _vkController),
            CustomButton(
              buttonText: 'Создать',
              onPressed: () => _showBottomSheet(context),
              MiniButton: false,
            ),
          ],
        ),
      ),
    );
  }
}
