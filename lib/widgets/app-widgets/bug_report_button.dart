import 'package:flutter/material.dart';
import 'package:lifeguard/api-services/bug_report_service.dart';

class BugReportButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BugReportService().reportBug(context);
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Icon(Icons.bug_report, size: 20, color: ColorScheme.of(context).secondary),
      ),
    );
  }
}