import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {

  CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();



  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom:10, left:10, right:10),
        padding: EdgeInsets.only(top: 10, bottom:10, left:10, right:10),
        constraints: BoxConstraints(
          maxWidth: 800,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: TableCalendar(
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: 'ru_RU',
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: {CalendarFormat.month: 'month'},
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontSize: 20, height: -0.1, color: Colors.black),
            weekendStyle: TextStyle(fontSize: 20, height: -0.1, color: Colors.red),
          ),
          headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: TextStyle(color: Colors.black),
            weekendTextStyle: TextStyle(color: Colors.red),
            outsideTextStyle: TextStyle(color: Colors.grey[400]),
          ),
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  '${date.day}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
            selectedBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(
                  '${date.day}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
