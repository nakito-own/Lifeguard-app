import 'package:flutter/material.dart';
import '../api-services/role_service.dart';
import '../models/role_model.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/role-widgets/role_dropdown_widget.dart';

class RolesScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  RolesScreen({required this.toggleTheme});

  @override
  _RolesScreenState createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  RoleService roleService = RoleService();
  List<RoleModel> roles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      final fetchedRoles = await roleService.getRoles();
      setState(() {
        roles = fetchedRoles;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка при загрузке ролей')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление ролями'),
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: roles.length,
          itemBuilder: (context, index) {
            return RoleDropdownWidget(
              role: roles[index],
              roleService: roleService,
            );
          },
        ),
      ),
    );
  }
}
