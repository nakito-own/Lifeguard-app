import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/api-services/show_staff_service.dart';

class ShowStaffWidget extends StatefulWidget {
  final int staffId;

  ShowStaffWidget({required this.staffId});

  @override
  _ShowStaffWidgetState createState() => _ShowStaffWidgetState();
}

class _ShowStaffWidgetState extends State<ShowStaffWidget> {
  late Future<Staff> futureStaff;
  final ShowStaffService _service = ShowStaffService();

  @override
  void initState() {
    super.initState();
    futureStaff = _service.fetchStaffById(widget.staffId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Staff>(
      future: futureStaff,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error: ${snapshot.error}'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else if (snapshot.hasData) {
          Staff staff = snapshot.data!;
          return AlertDialog(
            title: Text('${staff.name} ${staff.surname}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Name: ${staff.name}'),
                  Text('Surname: ${staff.surname}'),
                  Text('Patronymic: ${staff.patronymic}'),
                  Text('Nick: ${staff.nick}'),
                  Text('Phone: ${staff.phone}'),
                  Text('Email: ${staff.email}'),
                  Text('Telegram: ${staff.tg}'),
                  Text('VK: ${staff.vk}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('No data'),
            content: Text('No data available for the requested staff.'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
