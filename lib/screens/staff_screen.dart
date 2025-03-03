// staff_list_screen.dart

import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/widgets/app-widgets/app_drawer.dart';
import 'package:lifeguard/widgets/staff-widgets/staff_card.dart';
import 'package:lifeguard/api-services/staff_service.dart';
import 'package:lifeguard/widgets/app-widgets/search_bar.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'create_user_screen.dart';

class StaffListScreen extends StatefulWidget {

  StaffListScreen({super.key});

  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  late Future<List<Staff>> futureStaff;
  final StaffService staffService = StaffService();
  final PermissionsManager permissionsManager = PermissionsManager();
  List<Staff> filteredItems = [];
  bool hasAddUserPermission = false;
  Staff? selectedItem;

  @override
  void initState() {
    super.initState();
    futureStaff = staffService.fetchStaff();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    bool permission = await permissionsManager.hasPermission('user new');
    setState(() {
      hasAddUserPermission = permission;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сотрудники')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(children: [
          Expanded(
            child: FutureBuilder<List<Staff>>(
              future: futureStaff,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No staff found'));
                } else {
                  List<Staff> staff = snapshot.data!;
                  filteredItems = staff;
                  return Column(
                    children: [
                      CustomSearchBar(
                        items: staff,
                        onSearch: (results) {
                          setState(() {
                            if (results.length == 1) {
                              selectedItem = results.first;
                            } else {
                              selectedItem = null;
                            }
                            filteredItems = results;
                          });
                        },
                        isDarkTheme: Theme.of(context).brightness == Brightness.dark,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: selectedItem != null ? 1 : staff.length,
                          itemBuilder: (context, index) {
                            final displayItem = selectedItem ?? filteredItems[index];
                            return StaffCard(staff: displayItem);
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}