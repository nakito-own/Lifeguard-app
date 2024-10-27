import 'package:flutter/material.dart';
import '../../api-services/role_service.dart';
import '../../models/role_model.dart';
import '../../screens/role_details_screen.dart';

class RoleDropdownWidget extends StatefulWidget {
  final RoleModel role;
  final RoleService roleService;

  RoleDropdownWidget({required this.role, required this.roleService});

  @override
  _RoleDropdownWidgetState createState() => _RoleDropdownWidgetState();
}

class _RoleDropdownWidgetState extends State<RoleDropdownWidget> with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  Map<String, dynamic>? roleDetails;
  bool isLoadingDetails = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

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

    if (isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);
    final textColor = isDarkTheme ? Colors.white : Colors.black;

    return Card(
      color: cardColor,
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
                color: textColor,
              ),
            ),
            subtitle: Text(
              'Количество назначенных:',
              style: TextStyle(color: textColor),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isDarkTheme ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${widget.role.ownersCount}',
                style: TextStyle(color: textColor),
              ),
            ),
            onTap: _navigateToRoleDetailsScreen,
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: 0.0,
            child: isExpanded
                ? isLoadingDetails
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isDarkTheme ? Colors.grey[800] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${user['surname']} ${user['name']}',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            )
                : SizedBox()
                : SizedBox(),
          ),
          IconButton(
            icon: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: textColor,
            ),
            onPressed: _toggleExpanded,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
