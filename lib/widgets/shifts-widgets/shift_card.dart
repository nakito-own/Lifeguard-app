import 'package:flutter/material.dart';
import '../../models/shift_model.dart';

class ShiftCard extends StatelessWidget {
  final Shift shift;

  const ShiftCard({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 130
      ),
      child: Card(
        color: ColorScheme.of(context).primary,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: ListTile(
          title: Text('Смена #${shift.id}', style: TextTheme.of(context).bodyLarge),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (shift.comment.isNotEmpty) Text('${shift.comment}'),
              SizedBox(height: 4),
              Text('Начало: ${shift.timeStart}',style: TextTheme.of(context).bodySmall),
              if (shift.timeEnd.isNotEmpty) Text('Окончание: ${shift.timeEnd}', style: TextTheme.of(context).bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}