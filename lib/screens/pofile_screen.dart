import 'package:flutter/material.dart';
import '../api-services/image_service.dart';
import '../models/user_model.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';
import '../widgets/app-widgets/error_widget.dart';
import '../widgets/profile-widgets/profile_header_widget.dart';
import '../widgets/profile-widgets/my_info.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>?> _userDataFuture;
  final TextEditingController phone = TextEditingController();
  final TextEditingController vk = TextEditingController();
  final TextEditingController tg = TextEditingController();
  final TextEditingController mail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userDataFuture = User().getUserData();
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorAlertDialog(
          errorMessage: errorMessage,
        );
      },
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Телефон', phone, Icons.phone),
                SizedBox(height: 15),
                _buildTextField('VK', vk, Icons.link),
                SizedBox(height: 15),
                _buildTextField('TG', tg, Icons.telegram),
                SizedBox(height: 15),
                _buildTextField('Почта', mail, Icons.email),
                SizedBox(height: 25),
                CustomButton(
                  buttonText: 'Сохранить',
                  MiniButton: true,
                  onPressed: () {
                    print('${phone.text}, ${vk.text}, ${tg.text}, ${mail.text}');
                    _showErrorDialog('Данные отправлены');
                    Navigator.pop(context);
                    phone.clear();
                    vk.clear();
                    tg.clear();
                    mail.clear();
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return CustomTextField(
      text: '',
      lines: 1,
      labelText: label,
      widthSize: double.infinity,
      heightSize: 42,
      icon: Icon(icon),
      controller: controller,
      isObscured: false,
      togglePass: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<Map<String, dynamic>?> (
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User info is not found'));
          } else {
            final userData = snapshot.data!;
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  FutureBuilder<Image>(
                    future: userData['image'] != null && userData['image'].isNotEmpty
                        ? ImageService().fetchImage('users', userData['image'])
                        : Future.error('No image available'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(radius: 50, child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return CircleAvatar(radius: 50, child: Icon(Icons.account_circle, size: 70));
                      } else {
                        return CircleAvatar(radius: 50, backgroundImage: snapshot.data?.image);
                      }
                    },
                  ),
                  ProfileHeaderWidget(
                    FirstName: userData['name'],
                    SecondName: userData['surname'],
                    Patronymic: userData['patronymic'],
                  ),
                  MyInfo(
                    phone: userData['phone'],
                    VK_Link: userData['vk'],
                    TG_Link: userData['tg'],
                    Mail_Link: userData['email'],
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: 1170
                    ),
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorScheme.of(context).primary
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('  Личное дело', style: TextTheme.of(context).bodyMedium),
                        Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.link))
                      ],
                    ),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () => _showEditBottomSheet(context),
                      child: Text('Редактировать личные данные')
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          }
        }
      )
    );
  }
}
