import 'package:flutter/material.dart';
import '../../api-services/role_service.dart';
import '../../models/role_model.dart';

class RoleDropdownWidget extends StatefulWidget {
  final RoleModel role;
  final RoleService roleService;

  RoleDropdownWidget({required this.role, required this.roleService});

  @override
  _RoleDropdownWidgetState createState() => _RoleDropdownWidgetState();
}

class _RoleDropdownWidgetState extends State<RoleDropdownWidget> {
  bool isExpanded = false;
  Map<String, dynamic>? roleDetails;
  bool isLoadingDetails = false;

  Future<void> _fetchRoleDetails() async {
    setState(() {
      isLoadingDetails = true;
    });

    try {
      final details = await widget.roleService.getRoleById(widget.role.rankId);
      setState(() {
        roleDetails = details;
        isLoadingDetails = false;
      });
    } catch (error) {
      setState(() {
        isLoadingDetails = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при загрузке информации о роли')));
    }
  }

  void _toggleExpanded() async {
    setState(() {
      isExpanded = !isExpanded;
    });

    if (isExpanded && roleDetails == null) {
      await _fetchRoleDetails();
    }
  }

  void _navigateToRoleDetailsScreen() {
    if (roleDetails != null) {
      final List<Map<String, dynamic>> permissions = List<Map<String, dynamic>>.from(roleDetails!['actions'] ?? []);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoleDetailsScreen(
            roleName: widget.role.rankName,
            permissions: permissions,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.role.rankName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              'Количество назначенных: ${widget.role.ownersCount}',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${widget.role.ownersCount}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: _navigateToRoleDetailsScreen,
          ),
          if (isExpanded)
            isLoadingDetails
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            )
                : roleDetails != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var user in roleDetails!['users'])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '${user['surname']} ${user['name']}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                ],
              ),
            )
                : SizedBox(),
          IconButton(
            icon: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
            ),
            onPressed: _toggleExpanded,
          ),
        ],
      ),
    );
  }
}

class RoleDetailsScreen extends StatelessWidget {
  final String roleName;
  final List<Map<String, dynamic>> permissions;

  RoleDetailsScreen({required this.roleName, required this.permissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roleName),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Разрешения роли:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            for (var permission in permissions)
              Card(
                color: Colors.grey[800],
                margin: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    permission['actionName'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
