import 'package:flutter/material.dart';
import 'package:stars_studios/enums/status.dart';

class ClassListRow extends StatelessWidget {
  final String date;
  final String time;
  final String coach;
  final Status status;

  const ClassListRow({
    super.key, 
    required this.date, 
    required this.time, 
    required this.coach, 
    required this.status,
  });

  @override
  Widget build(BuildContext context) {

    final Icon icon = 
      status == Status.booked ? const Icon(Icons.schedule) : 
      status == Status.cancelled ? const Icon(Icons.cancel) : 
      const Icon(Icons.check);

    return Container(
      color: Colors.grey[100],
      margin: const EdgeInsets.only(bottom: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Center(child: Text(date))),
            Expanded(child: Center(child: Text(time))),
            Expanded(child: Center(child: Text(coach))),
            Expanded(child: Center(child: icon,)),
          ]
        ),
      ),
    );
  }
}