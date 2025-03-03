import 'package:flutter/material.dart';
import '../widgets/app-widgets/app_drawer.dart';

class CallsScreen extends StatelessWidget {

  CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Вызовы'),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month)),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
            padding: EdgeInsets.only(top: 10, bottom:10, left:10, right:10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                ]
            )
        )
    );
  }
}
