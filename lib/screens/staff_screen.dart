// staff_list_screen.dart
import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/widgets/app-widgets/app_drawer.dart';
import 'package:lifeguard/widgets/staff-widgets/add_button.dart';
import 'package:lifeguard/widgets/staff-widgets/staff_card.dart';
import 'package:lifeguard/api-services/staff_service.dart';
import 'package:lifeguard/widgets/search_bar.dart';

import '../widgets/app-widgets/custom_button.dart';

class StaffListScreen extends StatefulWidget {

  final VoidCallback toggleTheme;

  StaffListScreen({required this.toggleTheme});

  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  late Future<List<Staff>> futureStaff;
  final StaffService staffService = StaffService();
  List<Staff> filteredItems = [];
  Staff? selectedItem;

  @override
  void initState() {
    super.initState();
    futureStaff = staffService.fetchStaff();
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники')
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: Column(
        children: [
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
                  ),
              Expanded (
                  child:
              ListView.builder(
                itemCount: selectedItem != null ? 1 : staff.length,
                itemBuilder: (context, index) {
                  final displayItem = selectedItem ?? filteredItems[index];
                  return StaffCard(staff: displayItem); // Используем индексирование на списке staff
                },
              ),
              ),
                AddButton(),
              ],
            );
          }
        },
      ),
    ),
    ]
    ),
    );
  }
}
