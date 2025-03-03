import 'package:flutter/material.dart';
import '../api-services/role_service.dart';
import '../models/role_model.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/role-widgets/role_dropdown_widget.dart';
import 'package:lifeguard/utils/permissions_manager.dart';

class RolesScreen extends StatefulWidget {

  RolesScreen({super.key});

  @override
  _RolesScreenState createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  RoleService roleService = RoleService();
  final PermissionsManager permissionsManager = PermissionsManager();
  List<RoleModel> roles = [];
  bool hasAddRolePermission = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    bool permission = await permissionsManager.hasPermission('role new');
    setState(() {
      hasAddRolePermission = permission;
    });
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
      drawer: AppDrawer(),
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
      floatingActionButton: hasAddRolePermission
          ? FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
        },
        child: Text("+", style: TextStyle(fontSize: 24)),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
