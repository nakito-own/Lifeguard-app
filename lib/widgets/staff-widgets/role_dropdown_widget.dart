import 'package:flutter/material.dart';
import '../../api-services/role_service.dart';
import '../../models/role_model.dart';

class RoleDropdown extends StatefulWidget {
  final TextEditingController controller;

  RoleDropdown({required this.controller});

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  final RoleService _roleService = RoleService();
  List<RoleModel> _roles = [];
  RoleModel? _selectedRole;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      List<RoleModel> roles = await _roleService.getRoles();
      setState(() {
        _roles = roles;
      });
    } catch (e) {
      print('Failed to load roles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1400),
        child: SizedBox(
          height: 60,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Выберите роль',
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff7e7e7e),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff7e7e7e),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff7e7e7e),
                  width: 2,
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<RoleModel>(
                value: _selectedRole,
                hint: Text(
                  'Выберите роль',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff7e7e7e),
                  ),
                ),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: Color(0xff7e7e7e)),
                onChanged: (RoleModel? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                    widget.controller.text = newValue?.rankName ?? '';
                  });
                },
                items: _roles.map<DropdownMenuItem<RoleModel>>((RoleModel role) {
                  return DropdownMenuItem<RoleModel>(
                    value: role,
                    child: Text(role.rankName),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
