import 'package:flutter/material.dart';
import '../api-services/shifts_service.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/app-widgets/custom_button.dart';
import '../widgets/events-widgets/calendar_widget.dart';
import '../models/shift_model.dart';
import 'package:lifeguard/widgets/shifts-widgets/shift_card.dart';

class ShiftScreen extends StatelessWidget {
  final ShiftService shiftService = ShiftService();

  ShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Смены'),
        ),
        drawer: AppDrawer(),
        body: Padding(
            padding: EdgeInsets.only(top: 10, bottom:10, left:10, right:10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CalendarWidget(),
                  SizedBox(height: 10),
                  CustomButton(
                    buttonText: 'Создать смену',
                    onPressed: () {  },
                    MiniButton: false,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder<List<Shift>>(
                      future: shiftService.fetchShifts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Ошибка: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('Нет данных о сменах'));
                        } else {
                          List<Shift> shifts = snapshot.data!;
                          return ListView.builder(
                            itemCount: shifts.length,
                            itemBuilder: (context, index) {
                              return ShiftCard(shift: shifts[index]);
                            },
                          );
                        }
                      },
                    )
                  )
                ]
            )
        )
    );
  }
}