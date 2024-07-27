// staff_list_screen.dart
import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/widgets/app-widgets/app_drawer.dart';
import 'package:lifeguard/widgets/staff-widgets/staff_widget.dart';
import 'package:lifeguard/api-services/staff_service.dart';

class StaffListScreen extends StatefulWidget {

  final VoidCallback toggleTheme;

  StaffListScreen({required this.toggleTheme});

  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  late Future<List<Staff>> futureStaff;
  final StaffService staffService = StaffService();

  @override
  void initState() {
    super.initState();
    futureStaff = staffService.fetchStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: FutureBuilder<List<Staff>>(
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
            return ListView.builder(
              itemCount: staff.length,
              itemBuilder: (context, index) {
                return StaffCard(staff: staff[index]); // Используем индексирование на списке staff
              },
            );
          }
        },
      ),
    );
  }
}
